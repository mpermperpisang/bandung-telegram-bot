module Bot
  class Command
    class Lock < Command
      @@staging = Staging.new
      @@jenkins = BBMJenkins.new

      def lock_release
        unless @@staging.is_empty?(@bot, @id, @message, @base_command, @staging)
          self.release_lock
        end
      end

      def release_lock
        if [*1..127].include?(@staging.to_i)
          staging = @staging
        else
          staging = "new"
        end

        staging == "new"?
        @bot.api.send_message(chat_id: @id, text: new_staging(@message.from.username, @staging), parse_mode: 'HTML') :
        Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).queueing_request("lock_#{@staging}", @staging, "lock:release")
      end
    end
  end
end
