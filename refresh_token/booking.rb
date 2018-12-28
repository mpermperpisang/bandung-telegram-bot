require './require/gem.rb'

@token = ENV['TOKEN_BOOKING']

Telegram::Bot::Client.run(@token) do |bot|
  bot.listen do |message|
    @id = message.chat.id
    @first_name = message.chat.first_name

    begin
      case message.text
      when '/start'
        bot.api.send_message(chat_id: @id, text: "Hello, #{@first_name}")
      when '/stop'
        bot.api.send_message(chat_id: @id, text: "Bye, #{@first_name}")
      end
    rescue StandardError => e
      puts e
    end
  end
end
