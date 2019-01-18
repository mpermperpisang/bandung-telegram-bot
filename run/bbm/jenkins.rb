require './require.rb'

@token = ENV['TOKEN_JENKINS']
@chat_id = ENV['ID_JENKINS']
@private = ENV['ID_PRIVATE']

@msg = MessageText.new
@db = Connection.new
@status = ConnectionStatus.new
@is_group = Group.new
@chat = Chat.new

bot_start = Telegram::Bot::Client.new(@token)
p 'jenkins online'
@status.online(@token, @private, bot_start, '')

Telegram::Bot::Client.run(@token) do |bot|
  begin
    bot.listen do |message|
      @txt = message.text
      next unless @txt # txt nil?
      @msg.read_text(@txt)

      if @is_group.not_private_chat?(message.chat.type)
        command = [
          '/deploy', '/lock', '/start', '/restart', '/stop', '/deployment',
          '/migrate', '/reindex', '/precompile', '/normalize', "/help@#{ENV['BOT_JENKINS']}"
        ]

        if command.include?(@msg.bot_name) || command.include?(@msg.booking_name) || command.include?(@msg.command)
          jenkins_group(@token, @chat_id, bot, message, @txt)
          @chat.delete(bot, message.chat.id, message.message_id)
        end
      else
        jenkins_private(@token, message.chat.id, bot, message, @txt)
      end
    end
  rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
    puts e
    sleep(5)
    retry
  rescue Telegram::Bot::Exceptions::ResponseError => e
  	puts e
    sleep(5)
    retry
  rescue Mysql2::Error => e
  	puts e
  	sleep(5)
  	retry
  rescue StandardError => e
    chat_id = @db.message_chat_id

    chat_id.each do |id_grup|
      begin
        #@status.offline(@token, (id_grup['chat_id']).to_s, bot, mention_admin('jenkins'))
      rescue StandardError => err
        bot.api.send_message(chat_id: @private, text: chat_not_found)
        puts err
      end
    end

    bot.api.send_message(chat_id: @private, text: send_off('jenkins'))
    raise e
  end
end
