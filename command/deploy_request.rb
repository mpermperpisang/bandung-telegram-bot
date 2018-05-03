require './is_true/branch.rb'
require './is_true/user.rb'
require './is_true/bot_name.rb'
require './helper/bbm_booking.rb'

module Bot
  class Command
    class DeployRequest < Command
      @@user = User.new
      @@name = Name.new
      @@booking = BBMBooking.new
      @@branch = Branch.new

      def deploy_request
        unless @@branch.is_empty?(@bot, @id, @message, "@#{@space}", @command, @message.from.username)
          self.deploy_branch
        end
      end

      def deploy_branch
        unless @@user.is_developer?(@bot, @id, @message.from.username)
          deploy = Bot::DBConnect.new.check_deploy(@space.strip)
          book_staging = deploy.empty? ? nil : deploy[0]['deploy_branch']

          if book_staging == nil || book_staging.empty?
            Bot::DBConnect.new.deploy(@space.strip, @message.from.username)
          else
            Bot::DBConnect.new.update_deploy(@space.strip, @message.from.username)
          end

          @bot.api.send_message(chat_id: @id, text: msg_deploy(@message.from.username, @space.strip), parse_mode: 'HTML')
          Bot::Command::ListRequest.new(@token, @id, @bot, @message, @txt).list_deploy_request
        end
      end
    end
  end
end
