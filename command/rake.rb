module Bot
  class Command
    class Rake < Command
      def check_text
        check_stg_empty if @txt.start_with?('/migrate', '/reindex', '/precompile')
      end

      def check_stg_empty
        @is_staging = Staging.new
        @send = SendMessage.new

        rake_general unless @is_staging.empty?(@bot, @chatid, @staging, @username, @txt)
      end

      def rake_general
        staging = [*1..127].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@id, @username, @staging)
        staging == 'new' ? @bot.api.send_message(@send.message) : check_user_request
      end

      def check_user_request
        Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).check_requester
      end
    end
  end
end
