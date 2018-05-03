module Bot
  class Command
    # menyambut seseorang yang baru pertama kali japri bot
    class WelcomeText < Command
      def bot_start
        @bot.api.send_message(chat_id: @message.from.id, text: welcome_text(@firstname))
      rescue StandartError => exc
        @bot.api.send_message(chat_id: ENV['ID_PRIVATE'], text: blocked_bot(@username))
        puts exc
      end
    end
  end
end
