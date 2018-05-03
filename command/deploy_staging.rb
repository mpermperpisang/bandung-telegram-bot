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

        check_staging_empty if @txt.start_with?("/deploy_#{@msg.stg}", '/deploy') && @txt == @msg.req && @txt == @msg.deploy
      end

      def check_staging_empty
        @chatid = @message.chat.id
        next_staging_not_empty unless @is_staging.empty?(@bot, @chatid, @staging, @username, @txt)
      end

      def next_staging_not_empty
        staging = [*1..127].include?(@staging.to_i) ? @staging : 'new'
        branch = @space.nil? ? nil : @space.strip
        return if @is_branch.empty?(@bot, @id, branch, @txt, @username)

        @sendmessage = {
          chat_id: @id,
          text: new_staging(@username, @staging),
          parse_mode: 'HTML'
        }
        staging == 'new' ? @bot.api.send_message(@sendmessage) : check_user_qa
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
        @type_queue = @base_command.delete('/_')
        @ip_stg = "staging#{@staging}.vm"
        @ip_stg = '192.168.114.182' if @staging == '21'
        @ip_stg = '192.168.34.46' if @staging == '51'
        @ip_stg = '192.168.35.95' if @staging == '51'

        check_req_branch = @db.list_requester(@space)
        request_branch = check_req_branch.first['deploy_request'] unless check_req_branch.size.zero?
        requester = check_req_branch.size > 0 ? request_branch : nil

        @name = requester.nil? ? 'None' : "@#{requester}"

        check_deploy_queue if @name.nil? || @name == 'None'
        @db.list_queue(@username, @chatid, @ip_stg, @staging, @space, @type_queue) unless @name.nil?
        queueing_deployment
      end

      def check_deploy_queue
        check_deploy = @db.check_queue(@space)
        check_branch = check_deploy.first['deploy_branch']
        queue_branch = check_branch.empty? ? nil : check_branch

        case queue_branch
        when nil, ''
          @db.insert_queue(@username, @chatid, @ip_stg, @staging, @space, @type_queue)
        else
          @db.list_queue(@username, @chatid, @ip_stg, @staging, @space, @type_queue)
        end

        results_cap = @db.number_queue_cap
        @queue_cap = results_cap.count

        results_rake = @db.number_queue_rake
        @queue_rake = results_rake.count
      end

      def queueing_deployment
        case @type_queue
        when 'deploy'
          @sendmessage = {
            chat_id: @id,
            text: msg_queue_deploy(@username, @staging, @space, @name, @queue_cap),
            parse_mode: 'HTML'
          }
          @bot.api.send_message(@sendmessage)
          Bot::Command::Deployment.new(@token, @id, @bot, @message, @txt).deployment_staging
        when 'lock:release', 'backburner:start', 'backburner:restart', 'backburner:stop'
          @bot.api.send_message(chat_id: @id, text: msg_queue_cap(@type_queue, @staging, @queue_cap), parse_mode: 'HTML')
        when 'db:migrate', 'elasticsearch:reindex_index', 'assets:precompile'
          @bot.api.send_message(chat_id: @id, text: msg_queue_rake(staging, @queue_rake), parse_mode: 'HTML')
        end
      end
    end
  end
end
