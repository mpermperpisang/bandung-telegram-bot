module Bot
  class Command
    # untuk developer meminta deploy branch ke staging
    class DeployRequest < Command
      def check_text
        check_branch_empty if @txt.start_with?('/deploy_request')
      end

      def check_branch_empty
        @is_branch = Branch.new

        next_is_developer unless @is_branch.empty?(@bot, @chatid, @space, @txt, @username)
      end

      def next_is_developer
        @is_user = User.new

        deploy_branch unless @is_user.developer?(@bot, @chatid, @username)
      end

      def deploy_branch
        @db = Connection.new

        deploy = @db.check_deploy(@space)
        @book_staging = deploy.size.zero? ? nil : deploy.first['deploy_branch']

        @book_staging.nil? ? @db.deploy(@space, @username) : @db.update_deploy(@space, @username)
        @book_staging.nil? ? request_deploy : list_request
      end

      def request_deploy
        @bot.api.send_message(chat_id: @chatid, text: msg_deploy(@username, @space), parse_mode: 'HTML')
        Bot::Command::ListRequest.new(@token, @chatid, @bot, @message, @txt).list_deploy_request
      end

      def list_request
        @bot.api.send_message(chat_id: @chatid, text: list_request_access)
      end
    end
  end
end
