require './is_true/staging.rb'
require './is_true/branch.rb'
require './is_true/user.rb'
require './database/crud.rb'

module Bot
  class Command
    # antri deploy branch ke suatu staging
    class DeployStaging < Command
      def check_text
        @msg = MessageText.new
        @msg.read_text(@txt)
        @is_staging = Staging.new
        @is_branch = Branch.new
        @is_user = User.new
        @db = Connection.new
        @send = SendMessage.new

        check_stg_empty if @txt.start_with?("/deploy_#{@msg.stg}", '/deploy') && @txt == @msg.req && @txt == @msg.deploy
      end

      def check_stg_empty
        next_stg_not_empty unless @is_staging.empty?(@bot, @chatid, @staging, @username, @txt)
      end

      def next_stg_not_empty
        staging = [*1..127].include?(@staging.to_i) ? @staging : 'new'
        @branch = @space.nil? ? nil : @space.strip
        return if @is_branch.empty?(@bot, @id, @branch, @txt, @username)

        @send.check_new_staging(@id, @username, @staging)
        staging == 'new' ? @bot.api.send_message(@send.message) : check_user_qa
      end

      def check_user_qa
        check_stg_booked unless @is_user.quality_assurance?(@bot, @id, @username, @txt)
      end

      def check_stg_booked
        check_booked = @db.check_booked(@staging)
        staging = check_booked.first['book_status']
        @status = staging.empty? ? nil : staging

        return if @is_staging.booked?(@bot, @id, @username, @status) || @status.nil? || @status == ''
        check_stg_book_user
      end

      def check_stg_book_user
        check_done = @db.done_booking(@staging)
        staging = check_done.first['book_name'] || check_done.first['book_from_id']
        book_name = staging.empty? ? nil : check_done.first['book_name']
        from_id = staging.empty? ? nil : check_done.first['book_from_id']

        return check_requester if book_name == @username
        @send.err_deploy_chat(@id, @username, @staging, book_name)
        @bot.api.send_message(@send.message)

        begin
          @send.err_deploy_from(from_id, @username, @staging, book_name)
          @bot.api.send_message(@send.message)
        rescue StandardError => e
          p "#{e}\n#{from_id} #{book_name} belum japri jenkins bot"
        end
      end

      def check_requester
        @msg = MessageText.new
        @msg.read_text(@txt)
        @db = Connection.new

        @type_queue = @base_command.delete('/_')
        define_queue
        define_ip

        @req = @space.nil? ? @msg.bot_name : @space
        check_req_branch = @db.list_requester(@req)
        request_branch = check_req_branch.first['deploy_request'] unless check_req_branch.size.zero?
        requester = check_req_branch.size > 0 ? request_branch : nil

        @name = requester.nil? ? 'None' : "@#{requester}"

        check_deploy_queue if @name.nil? || @name == 'None'
        @db.list_queue(@username, @chatid, @ip_stg, @staging, @req, @def_queue) unless @name.nil?
        queueing_deployment
      end

      def define_queue
        @def_queue = @type_queue if @type_queue == 'deploy'
        @def_queue = 'lock:release' if @type_queue == 'lock'
        @def_queue = 'backburner:start' if @type_queue == 'start'
        @def_queue = 'backburner:restart' if @type_queue == 'restart'
        @def_queue = 'backburner:stop' if @type_queue == 'stop'
        @def_queue = 'db:migrate' if @type_queue == 'migrate'
        @def_queue = 'elasticsearch:reindex_index' if @type_queue == 'reindex'
        @def_queue = 'assets:precompile' if @type_queue == 'precompile'
      end

      def define_ip
        @ip_stg = "staging#{@staging}.vm"
        @ip_stg = '192.168.114.182' if @staging == '21'
        @ip_stg = '192.168.34.46' if @staging == '51'
        @ip_stg = '192.168.35.95' if @staging == '103'
      end

      def check_deploy_queue
        check_deploy = @db.check_queue(@req)
        queue_branch = check_deploy.size.zero? ? nil : check_deploy.first['deploy_branch']

        case queue_branch
        when nil, ''
          @db.insert_queue(@username, @chatid, @ip_stg, @staging, @req, @def_queue)
        else
          @db.list_queue(@username, @chatid, @ip_stg, @staging, @req, @def_queue)
        end

        results_cap = @db.number_queue_cap
        @queue_cap = results_cap.count

        results_rake = @db.number_queue_rake
        @queue_rake = results_rake.count
      end

      def queueing_deployment
        case @type_queue
        when 'deploy'
          @send.queue_deployment(@id, @username, @staging, @req, @name, @queue_cap)
          @bot.api.send_message(@send.message)
          Bot::Command::Deployment.new(@token, @id, @bot, @message, @txt).deployment_staging
        when 'lock', 'start', 'stop', 'restart'
          @bot.api.send_message(chat_id: @id, text: msg_queue_cap(@type_queue, @staging, @queue_cap), parse_mode: 'HTML')
        when 'migrate', 'reindex', 'precompile'
          @bot.api.send_message(chat_id: @id, text: msg_queue_rake(@type_queue, @staging, @queue_rake), parse_mode: 'HTML')
        end
      end
    end
  end
end
