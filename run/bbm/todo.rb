require './require.rb'

@token = ENV['TOKEN_TODO']
@chat_id = ENV['ID_TODO']
@private = ENV['ID_PRIVATE']

@status = ConnectionStatus.new
@msg = MessageText.new
@is_group = Group.new
@chat = Chat.new
@db = Connection.new

bot_start = Telegram::Bot::Client.new(@token)
p 'todo online'
@status.online(@token, @chat_id, bot_start, '')

Telegram::Bot::Client.run(@token) do |bot|
  begin
    bot.listen do |message|
      case message
      when Telegram::Bot::Types::CallbackQuery
        @db.id_get_poin(message.from.username, message.from.id)
        Bot::Command::Poin.new(@token, @chat_id, bot, message, message.data).check_text
      when Telegram::Bot::Types::Message
        @txt = message.text
        next unless @txt # txt nil?
        @msg.read_text(@txt)

        if @is_group.not_private_chat?(message.chat.type)
          command = [
            '/retro', '/list_retro', '/poin', '/show',
            '0', '1/2', '1', '2', '3', '5', '8', '13', '20', '40', '100',
            'kopi', 'unlimited', "/help@#{ENV['BOT_TODO']}"
          ]

          if command.include?(@msg.bot_name) || command.include?(@msg.bot_poin) || command.include?(@msg.command)
            @msg_id = message.message_id

            @db.update_message_id(@msg_id) if @txt.start_with?('/show')
            todo_group(@token, @chat_id, bot, message, @txt)
            @chat.delete(bot, message.chat.id, message.message_id)
          end
        else
          todo_private(@token, message.from.id, bot, message, @txt)
        end
      end
    end
  rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
    puts e
    sleep(5)
    retry
  rescue Telegram::Bot::Exceptions::ResponseError => e
    puts telegram_error if e.error_code.to_s == '502' || e.error_code.to_s == '400'
    retry
  rescue StandardError => e
    @status.offline(@token, @chat_id, bot, mention_admin('todo'))
    bot.api.send_message(chat_id: @private, text: send_off('todo'))
    raise e
  end
end
