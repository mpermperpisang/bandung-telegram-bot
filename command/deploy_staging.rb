module Bot
  class Command
    class DeployStaging < Command
      @@staging = Staging.new
      @@branch = Branch.new
      @@user = User.new
      @@jenkins = BBMJenkins.new
      @@booking = BBMBooking.new

      def deploy_staging
        unless @@staging.is_empty?(@bot, @id, @message, @base_command, @staging)
          if [*1..127].include?(@staging.to_i)
            staging = @staging
          else
            staging = "new"
          end

          begin
            branch = @space.strip
          rescue
            branch = nil
          end

          unless @@branch.is_empty?(@bot, @id, @message, branch, @txt, @message.from.username)
            staging == "new"?
            @bot.api.send_message(chat_id: @id, text: new_staging(@message.from.username, @staging), parse_mode: 'HTML') :
            self.jenkins
          end
        end
      end

      def jenkins
        unless @@user.is_quality_assurance?(@bot, @id, @message.from.username)
          staging = Bot::DBConnect.new.check_booked(@staging)
          status = staging.empty? ? nil : staging[0]['book_status']

          if @@staging.is_booked?(status) || status == nil || status == ""
            self.jenkins_deploy
          else
            @bot.api.send_message(chat_id: @id, text: msg_block_deploy(@message.from.username))
          end
        end
      end

      def jenkins_deploy
        staging = Bot::DBConnect.new.done_booking(@staging)
        book_name = staging.empty? ? nil : staging[0]['book_name']
        book_from_id = staging.empty? ? nil : staging[0]['book_from_id']

        if (book_name == "#{@message.from.username}")
          self.queueing_request(@space.strip, @staging, "deploy")
        else
          begin
            @bot.api.send_message(chat_id: @id, text: errorDeploy(@message.from.username, @staging, book_name), parse_mode: 'HTML')
            @bot.api.send_message(chat_id: book_from_id, text: errorDeploy(@message.from.username, @staging, book_name), parse_mode: 'HTML')
          rescue
            p book_from_id
            p book_name
            p "belum japri jenkins bot"
          end
        end
      end

      def queueing_request(branch, staging, type_queue)
        ip = case staging
            when "21"
              "192.168.114.182"
            when "51"
              "192.168.34.46"
            when "103"
              "192.168.35.95"
            else
              "staging#{staging}.vm"
            end

        request_branch = Bot::DBConnect.new.list_requester(branch)
        requester = request_branch.empty? ? nil : request_branch[0]['deploy_request']

        name = case requester
              when nil, ""
                "None"
              else
                "@#{requester}"
              end

        case name
        when nil, "", "None"
          check_branch = Bot::DBConnect.new.check_branch_queue(branch)
          queue_branch = check_branch.empty? ? nil : check_branch[0]['deploy_branch']

          case queue_branch
          when nil, ""
            Bot::DBConnect.new.insert_queue(@message.from.username, @message.chat.id, ip, staging, branch, type_queue)
          else
            Bot::DBConnect.new.list_queue(@message.from.username, @message.chat.id, ip, staging, branch, type_queue)
          end
        else
          Bot::DBConnect.new.list_queue(@message.from.username, @message.chat.id, ip, staging, branch, type_queue)
        end

        results_cap = Bot::DBConnect.new.number_queue_cap
        @queue_cap = results_cap.count

        results_rake = Bot::DBConnect.new.number_queue_rake
        @queue_rake = results_rake.count

        if type_queue == "deploy"
          @bot.api.send_message(chat_id: @id, text: msg_queue_deploy(@message.from.username, staging, branch, name, @queue_cap), parse_mode: 'HTML')
          Bot::Command::Deployment.new(@token, @id, @bot, @message, @txt).deployment_staging
        elsif type_queue == "lock:release"
          @bot.api.send_message(chat_id: @id, text: msg_queue_lock(staging, @queue_cap), parse_mode: 'HTML')
        elsif type_queue == "backburner:start" || type_queue == "backburner:restart" || type_queue == "backburner:stop"
          @bot.api.send_message(chat_id: @id, text: msg_queue_backburner(type_queue, staging, @queue_cap), parse_mode: 'HTML')
        elsif type_queue == "db:migrate"
          @bot.api.send_message(chat_id: @id, text: msg_queue_migrate(staging, @queue_rake), parse_mode: 'HTML')
        elsif type_queue == "elasticsearch:reindex_index"
          @bot.api.send_message(chat_id: @id, text: msg_queue_reindex(staging, @queue_rake), parse_mode: 'HTML')
        elsif type_queue == "assets:precompile"
          @bot.api.send_message(chat_id: @id, text: msg_queue_precompile(staging, @queue_rake), parse_mode: 'HTML')
        end
      end
    end
  end
end
