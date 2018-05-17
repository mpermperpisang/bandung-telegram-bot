require './require.rb'

@token = ENV['TOKEN_BOOKING']
@chat_id = ENV['ID_BOOKING']
@private = ENV['ID_PRIVATE']

@status = ConnectionStatus.new
@msg = MessageText.new
@is_group = Group.new
@chat = Chat.new

bot_start = Telegram::Bot::Client.new(@token)
p 'booking online'
@status.online(@token, @chat_id, bot_start, '')

Telegram::Bot::Client.run(@token) do |bot|
  begin
    bot.listen do |message|
      case message
      when Telegram::Bot::Types::Message
        @txt = message.text
        next unless @txt # txt nil?
        @msg.read_text(@txt)

        if @is_group.not_private_chat?(message.chat.type)
          command = [
            '/deploy_request', '/cancel_request', '/done', '/list_request', '/booking', '/status',
            "/help@#{ENV['BOT_BOOKING']}"
          ]

          if command.include?(@msg.bot_name) || command.include?(@msg.booking_name) || command.include?(@msg.command)
            booking_group(@token, @chat_id, bot, message, @txt)
            @chat.delete(bot, message.chat.id, message.message_id)
          end
        else
          booking_private(@token, message.from.id, bot, message, @txt)
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
    @status.offline(@token, @chat_id, bot, mention_admin('booking'))
    bot.api.send_message(chat_id: @private, text: send_off('booking'))
    raise e
  end
end
