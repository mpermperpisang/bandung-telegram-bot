module Bot
  class Command
    # untuk start/restart/stop backburner di staging
    class Backburner < Command
      def check_text
        check_stg_empty if @txt.start_with?('/start', '/restart', '/stop')
      end

      def check_stg_empty
        @is_staging = Staging.new

        backburner_general unless @is_staging.empty?(@bot, @chatid, @staging, @username, @command)
      end

      def backburner_general
        @send = SendMessage.new

        staging = [*1..132].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@chatid, @username, @staging)
        staging == 'new' ? @bot.api.send_message(@send.message) : check_user_request
      end

      def check_user_request
        Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).check_requester
      end
    end
  end
end
