require './require.rb'

@token = ENV['TOKEN_JENKINS']
@chat_id = ENV['ID_JENKINS']
<<<<<<< HEAD
@private = ENV['ID_PRIVATE']

@msg = MessageText.new
@db = Connection.new
@status = ConnectionStatus.new
@is_group = Group.new
@chat = Chat.new

bot_start = Telegram::Bot::Client.new(@token)
p 'jenkins online'
chat_id = @db.message_chat_id

chat_id.each do |id_grup|
  begin
    @status.online(@token, (id_grup['chat_id']).to_s, bot_start, '')
  rescue StandardError => e
    p id_grup['chat_id']
    bot_start.api.send_message(chat_id: @private, text: chat_not_found)
=======

@msg = MessageText.new
@group = Group.new
@status = ConnectionStatus.new
@chat = Chat.new
@jenkins = BBMJenkins.new

bot_start = Telegram::Bot::Client.new(@token)
p "jenkins online"
chat_id = Bot::DBConnect.new.message_chat_id

chat_id.each do |id_grup|
  begin
    @status.online(@token, "#{id_grup['chat_id']}", bot_start, "")
  rescue Exception => e
    p id_grup['chat_id']
    bot_start.api.send_message(chat_id: "276637527", text: "Jenkins chat not found, please check @mpermperpisang")
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
    puts e
  end
end

Telegram::Bot::Client.run(@token) do |bot|
  begin
    bot.listen do |message|
      @txt = message.text
      next unless @txt # txt nil?
      @msg.read_text(@txt)

<<<<<<< HEAD
      if @is_group.not_private_chat?(message.chat.type)
        command = [
          '/deploy', '/lock', '/start', '/restart', '/stop', '/deployment',
          '/migrate', '/reindex', '/precompile', '/normalize', '/help'
        ]

        if command.include?(@msg.bot_name) || command.include?(@msg.booking_name)
          jenkins_group(@token, @chat_id, bot, message, @txt)
          @chat.delete(bot, message.chat.id, message.message_id)
        end
      else
        jenkins_private
=======
      if @group.is_not_private?(message.chat.type)
        command = ["/deploy", "/lock", "/start", "/precompile", "/restart", "/deployment", "/stop", "/migrate", "/reindex", "/normalize", "/help"]

        if command.include?(@msg.bot_name) || command.include?(@msg.booking_name)
          Bot::Command::DeployStaging.new(@token, message.chat.id, bot, message, @txt).deploy_staging if @txt.start_with?("/deploy_#{@msg.staging}", "/deploy") && @txt == @msg.request && @txt == @msg.deployment
          Bot::Command::Deployment.new(@token, message.chat.id, bot, message, @txt).deployment_staging if @txt.start_with?("/deployment")
          Bot::Command::Lock.new(@token, message.chat.id, bot, message, @txt).lock_release if @txt.start_with?("/lock")
          Bot::Command::Backburner.new(@token, message.chat.id, bot, message, @txt).action("start") if @txt.start_with?("/start")
          Bot::Command::Backburner.new(@token, message.chat.id, bot, message, @txt).action("restart") if @txt.start_with?("/restart")
          Bot::Command::Backburner.new(@token, message.chat.id, bot, message, @txt).action("stop") if @txt.start_with?("/stop")
          Bot::Command::Rake.new(@token, message.chat.id, bot, message, @txt).action("migrate") if @txt.start_with?("/migrate")
          Bot::Command::Rake.new(@token, message.chat.id, bot, message, @txt).action("reindex") if @txt.start_with?("/reindex")
          Bot::Command::Rake.new(@token, message.chat.id, bot, message, @txt).action("precompile") if @txt.start_with?("/precompile")
          Bot::Command::Normalize.new(@token, message.chat.id, bot, message, @txt).normal_date if @txt.start_with?("/normalize")
          Bot::Command::Help.new(@token, message.chat.id, bot, message, @txt).group if @txt.start_with?("/help@#{ENV['BOT_JENKINS']}")
          @chat.delete(bot, message.chat.id, message.message_id)
        end
      else
        Bot::Command::Help.new(@token, @chat_id, bot, message, @txt).private if @txt == "/help"
        Bot::Command::WelcomeText.new(@token, @chat_id, bot, message, @txt).bot_start if @txt == "/start"
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
      end
    end
  rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
    puts e
    sleep(5)
    retry
  rescue Telegram::Bot::Exceptions::ResponseError => e
<<<<<<< HEAD
    puts telegram_error if e.error_code.to_s == '502'
    retry
  rescue StandardError => e
    chat_id = @db.message_chat_id

    chat_id.each do |id_grup|
      begin
        @status.offline(@token, (id_grup['chat_id']).to_s, bot, mention_admin)
      rescue StandardError => err
        bot.api.send_message(chat_id: @private, text: chat_not_found)
=======
    if e.error_code.to_s == '502'
      puts 'telegram stuff, nothing to worry!'
    end
    retry
  rescue Exception => e
    chat_id = Bot::DBConnect.new.message_chat_id

    chat_id.each do |id_grup|
      begin
        @status.offline(@token, "#{id_grup['chat_id']}", bot, run_offline("jenkins"))
      rescue Exception => err
        bot.api.send_message(chat_id: "276637527", text: "Jenkins chat not found, please check @mpermperpisang")
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
        puts err
      end
    end

<<<<<<< HEAD
    bot.api.send_message(chat_id: @private, text: send_off('jenkins'))
=======
    bot.api.send_message(chat_id: "276637527", text: "Jenkins offline, please check @mpermperpisang")
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
    raise e
  end
end
