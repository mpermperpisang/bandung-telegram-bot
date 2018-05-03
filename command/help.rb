require './message/message_help.rb'

module Bot
  class Command
    class Help < Command
      @@message = HelpMessage.new

      def group
        @@message.name = @token
        @@message.message = @token
        @bot.api.send_message(chat_id: @message.chat.id, text: @@message.help_group(@message.from.username))
        @bot.api.send_message(chat_id: @message.from.id, text: @@message.help_private(@message.from.username), parse_mode: 'HTML')
      end

      def private
        @@message.message = @token
        @bot.api.send_message(chat_id: @message.chat.id, text: @@message.help_private(@message.from.username), parse_mode: 'HTML')
      end
    end
  end
end
