module Bot
  class Command
    class WelcomeText < Command
      def bot_start
        begin
          @bot.api.send_message(chat_id: @message.from.id, text: welcome_text(@message.from.first_name))
        rescue StandartError => exc
          @bot.api.send_message(chat_id: "276637527", text: "#{@message.from.username} ngeblock botnya, please check @mpermperpisang")
          puts exc
        end
      end
    end
  end
end
