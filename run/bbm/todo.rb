require './require.rb'

@token = ENV['TOKEN_TODO']
@id = ENV['ID_TODO']
@private = ENV['ID_PRIVATE']

@msg = MessageText.new
@group = Group.new
@status = ConnectionStatus.new
@id = Chat.new
@user = User.new

bot_start = Telegram::Bot::Client.new(@token)
p "todo online"
@status.online(@token, @id, bot_start, "")

Telegram::Bot::Client.run(@token) do |bot|
  begin
    bot.listen do |message|
      case message
      when Telegram::Bot::Types::CallbackQuery
        Bot::DBConnect.new.id_get_poin(message.from.username, message.from.id)
        Bot::Command::Poin.new(@token, @id, bot, message, message.data).poin_private(message.data)
      when Telegram::Bot::Types::Message
        @txt = message.text
        next unless @txt # txt nil?
        @msg.read_text(@txt)

        if @group.is_not_private?(message.chat.type)
          command = ["/retro", "/list_retro", "/poin", "/show", "0", "1/2", "1", "2", "3", "5", "8", "13", "20", "40", "100", "kopi", "unlimited", "/help"]

          if command.include?(@msg.bot_name) || command.include?(@msg.bot_poin)
            Bot::Command::Retro.new(@token, @id, bot, message, @txt).retro_group if @txt.start_with?("/retro")
            Bot::Command::ListRetro.new(@token, @id, bot, message, @txt).list_retro if @txt.start_with?("/list_retro")
            Bot::Command::Poin.new(@token, @id, bot, message, @txt).poin_group if @txt[0] != "/"
            Bot::Command::Help.new(@token, @id, bot, message, @txt).group if @txt.start_with?("/help@#{ENV['BOT_TODO']}")


            if @txt.start_with?('/show')
              @msg_id = message.message_id

              Bot::DBConnect.new.update_message_id(@msg_id)
              Bot::Command::Poin.new(@token, @id, bot, message, @txt).poin('show')
              bot.api.send_message(chat_id: @id, text: next_poin)
            end
            @id.delete(bot, @id, message.message_id)
          end
        else
          Bot::Command::Retro.new(@token, @id, bot, message, @txt).squad_retro if @txt.start_with?('/retro')
          Bot::Command::Poin.new(@token, @id, bot, message, @txt).show_private if @txt.start_with?('/list_retro')
          Bot::Command::Poin.new(@token, @id, bot, message, @txt).show_private if @txt == '/show'
          Bot::Command::Help.new(@token, @id, bot, message, @txt).private if @txt == '/help'
          Bot::Command::WelcomeText.new(@token, @id, bot, message, @txt).bot_start if @txt == '/start'

          if @txt[0] != '/'
            Bot::Command::Poin.new(@token, @id, bot, message, @txt).poin(@txt)
            bot.api.send_message(chat_id: message.from.id, text: show_command)
            Bot::Command::Poin.new(@token, @id, bot, message, @txt).mplace
          end
        end
      end
    end
  rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
    puts e
    sleep(5)
    retry
  rescue Telegram::Bot::Exceptions::ResponseError => e
    puts 'telegram stuff, nothing to worry!' if e.error_code.to_s == '502'
    retry
  rescue StandardError => e
    @status.offline(@token, @id, bot, run_offline('todo'))
    bot.api.send_message(chat_id: @private, text: bot_offline('Todo'))
    raise e
  end
end
