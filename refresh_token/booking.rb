require './require/gem.rb'

@token = ENV['TOKEN_BOOKING']

Telegram::Bot::Client.run(@token) do |bot|
  bot.listen do |message|
    begin
      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
      end
    rescue
      p "rescue"
    end
  end
end
