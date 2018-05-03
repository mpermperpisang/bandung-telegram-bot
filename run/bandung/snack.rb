require './require.rb'

@token = ENV['TOKEN_REMINDER']
@chat_id = ENV['ID_REMINDER']

@msg = MessageText.new
@group = Group.new
@status = ConnectionStatus.new
@chat = Chat.new
@today = Bot::TodayWeather.new
@reminder = BandungSnack.new
@dday = Day.new
@user = User.new

bot_start = Telegram::Bot::Client.new(@token)
@status.online(@token, @chat_id, bot_start, msg_weather(@today.weather, @today.poem))

Telegram::Bot::Client.run(@token) do |bot|
  begin
    bot.listen do |message|
      new_member(message, bot) #new member is coming
      left_member(message, bot) #member is left

      case message
      when Telegram::Bot::Types::CallbackQuery
        case message.data
        when "wtb", "bbm", "art", "core", "disco", "bandung", "email"
          @user.is_spammer?(bot, @chat_id, message.from.username, message, message.data)
          if @user.spam == false
            if message.data == "email"
              Bot::Command::Hi5.new(@token, @chat_id, bot, message, message.data).member_email
            else
              Bot::Command::Hi5.new(@token, @chat_id, bot, message, message.data).hi5_member((message.data).upcase)
            end
          end
        when "mon", "tue", "wed", "thu", "fri"
          @dday.read_day(message.data)
          count_schedule = Bot::DBConnect.new.snack_schedule(message.data)
          amount = count_schedule.count

          @reminder.gsub_name
          bot.api.send_message(chat_id: message.from.id, text: list_schedule(@dday.day_name, @reminder.name, amount), parse_mode: 'HTML')
        end
      when Telegram::Bot::Types::Message
        @txt = message.text
        next unless @txt #txt nil?
        @msg.read_text(@txt)

        if @group.is_not_private?(message.chat.type)
          command = ["/add", "/edit", "/delete", "/reminder", "/cancel", "/done", "/holiday", "/normal", "/change", "/hi5", "/help"]

          if command.include?(@msg.bot_name)
            Bot::Command::Add.new(@token, @chat_id, bot, message, @txt).add_snack if @txt.start_with?("/add")
            Bot::Command::Edit.new(@token, @chat_id, bot, message, @txt).edit_snack if @txt.start_with?("/edit")
            Bot::Command::Delete.new(@token, @chat_id, bot, message, @txt).delete_snack if @txt.start_with?("/delete")
            Bot::Command::DoneSnack.new(@token, @chat_id, bot, message, @txt).done_snack if @txt.start_with?("/done")
            Bot::Command::Reminder.new(@token, @chat_id, bot, message, @txt).reminder_snack if @txt.start_with?("/reminder")
            Bot::Command::CancelSnack.new(@token, @chat_id, bot, message, @txt).cancel_snack if @txt.start_with?("/cancel")
            Bot::Command::Holiday.new(@token, @chat_id, bot, message, @txt).holiday_snack if @txt.start_with?("/holiday")
            Bot::Command::Normal.new(@token, @chat_id, bot, message, @txt).normal_snack if @txt.start_with?("/normal")
            Bot::Command::Change.new(@token, @chat_id, bot, message, @txt).change_snack if @txt.start_with?("/change")
            Bot::Command::Hi5.new(@token, @chat_id, bot, message, @txt).bandung_hi5 if @txt.start_with?("/hi5")
            Bot::Command::Help.new(@token, @chat_id, bot, message, @txt).group if @txt.start_with?("/help@#{ENV['BOT_REMINDER']}")
            @chat.delete(bot, @chat_id, message.message_id)
          end
        else
          Bot::Command::Hi5.new(@token, @chat_id, bot, message, @txt).add_member(@txt) if @txt.start_with?("/hi5")
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
    @status.offline(@token, @chat_id, bot, run_offline("snack"))
    bot.api.send_message(chat_id: "276637527", text: "Snack offline, please check @mpermperpisang")
    raise e
  end
end
