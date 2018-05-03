require './require.rb'

@token = ENV['TOKEN_BOOKING']
@chat_id = ENV['ID_BOOKING']

@msg = MessageText.new
@group = Group.new
@status = ConnectionStatus.new
@chat = Chat.new
@booking = BBMBooking.new

bot_start = Telegram::Bot::Client.new(@token)
p "booking online"
@status.online(@token, @chat_id, bot_start, "")

Telegram::Bot::Client.run(@token) do |bot|
  begin
    bot.listen do |message|
      case message
      when Telegram::Bot::Types::Message
        @txt = message.text
        next unless @txt # txt nil?
        @msg.read_text(@txt)

        if @group.is_not_private?(message.chat.type)
          command = ["/deploy_request", "/cancel_request", "/done", "/list_request", "/booking", "/status", "/help"]

          if command.include?(@msg.bot_name) || command.include?(@msg.booking_name)
            Bot::Command::Booking.new(@token, message.chat.id, bot, message, @txt).booking_staging if @txt.start_with?("/booking")
            Bot::Command::DoneBooking.new(@token, message.chat.id, bot, message, @txt).done_booking if @txt.start_with?("/done_#{@msg.staging}", "/done")
            Bot::Command::DeployRequest.new(@token, message.chat.id, bot, message, @txt).deploy_request if @txt.start_with?("/deploy_request")
            Bot::Command::ListRequest.new(@token, message.chat.id, bot, message, @txt).list_deploy_request if @txt.start_with?("/list_request")
            Bot::Command::CancelDeploy.new(@token, message.chat.id, bot, message, @txt).cancel_deploy if @txt.start_with?("/cancel_request")
            Bot::Command::Status.new(@token, message.chat.id, bot, message, @txt).check_staging if @txt.start_with?("/status")
            Bot::Command::Help.new(@token, message.chat.id, bot, message, @txt).group if @txt.start_with?("/help@#{ENV['BOT_BOOKING']}")
            @chat.delete(bot, message.chat.id, message.message_id)
          end
        else
          Bot::Command::Help.new(@token, @chat_id, bot, message, @txt).private if @txt == "/help"
          Bot::Command::WelcomeText.new(@token, @chat_id, bot, message, @txt).bot_start if @txt == "/start"
        end
      end
    end
  rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
    puts e
    sleep(5)
    retry
  rescue Telegram::Bot::Exceptions::ResponseError => e
    if e.error_code.to_s == '502'
      puts 'telegram stuff, nothing to worry!'
    end
    retry
  rescue Exception => e
    @status.offline(@token, @chat_id, bot, run_offline("booking"))
    bot.api.send_message(chat_id: "276637527", text: "Booking offline, please check @mpermperpisang")
    raise e
  end
end
