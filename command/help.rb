module Bot
  class Command
    # untuk menampilkan bantuan tentang perintah-perintah bot
    class Help < Command
      def check_text
        @message = HelpMessage.new

        group if @txt.start_with?("/help@#{ENV['BOT_JENKINS']}", "/help@#{ENV['BOT_BOOKING']}",
                                  "/help@#{ENV['BOT_REMINDER']}", "/help@#{ENV['BOT_TODO']}")
        private if @txt == '/help'
      end

      def group
        @message.name = @token
        @message.message = @token
        @bot.api.send_message(chat_id: @chatid, text: @message.help_group(@username))
        @bot.api.send_message(chat_id: @fromid, text: @message.help_private(@username), parse_mode: 'HTML')
      end

      def private
        @message.message = @token
        @bot.api.send_message(chat_id: @fromid, text: @message.help_private(@username), parse_mode: 'HTML')
      end
    end
  end
end
