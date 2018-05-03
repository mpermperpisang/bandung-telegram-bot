require './is_true/branch.rb'

module Bot
  class Command
    class CancelDeploy < Command
      @@branch = Branch.new

      def cancel_deploy
        unless @@branch.is_empty?(@bot, @id, @message, "@#{@space}", @command, @message.from.username)
          self.deploy_cancel
        end
      end

      def deploy_cancel
        cancel = Bot::DBConnect.new.check_deploy_req(@space.strip)

        unless cancel == nil || cancel.empty?
          @bot.api.send_message(chat_id: @id, text: msg_cancel_deploy(@space.strip), parse_mode: 'HTML')
          Bot::DBConnect.new.cancel_deploy(@space.strip)
        else
          @bot.api.send_message(chat_id: @id, text: cancel_empty(@message.from.username, @space.strip), parse_mode: 'HTML')
        end
      end
    end
  end
end
