require './require/gem.rb'

@token = ENV['TOKEN_TODO']

Telegram::Bot::Client.run(@token) do |bot|
  bot.listen do |message|
<<<<<<< HEAD
    @id = message.chat.id
    @first_name = message.from.first_name

    begin
      case message.text
      when '/start'
        bot.api.send_message(chat_id: @id, text: "Hello, #{@first_name}")
      when '/stop'
        bot.api.send_message(chat_id: @id, text: "Bye, #{@first_name}")
      end
    rescue StandardError => e
      puts e
=======
    begin
      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
      end
    rescue
      p "rescue"
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
    end
  end
end
