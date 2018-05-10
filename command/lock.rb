module Bot
  class Command
    # untuk lock:release log staging
    class Lock < Command
      def check_text
        check_stg_empty if @txt.start_with?('/lock')
      end

      def check_stg_empty
        @is_staging = Staging.new

        release_lock unless @is_staging.empty?(@bot, @chatid, @staging, @username, @command)
      end

      def release_lock
        @send = SendMessage.new

        staging = [*1..132].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@id, @username, @staging)
        staging == 'new' ? @bot.api.send_message(@send.message) : check_user_request
      end

      def check_user_request
        Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).check_requester
      end
    end
  end
end
