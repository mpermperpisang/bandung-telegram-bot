require './helper/bot_status.rb'

class ConnectionStatus
  @@conn = BotStatus.new

  def online(token, chat_id, bot, add)
    @@conn.type_status = :online
    status(token, chat_id, bot, add)
  end

  def offline(token, chat_id, bot, add)
    @@conn.type_status = :offline
    status(token, chat_id, bot, add)
  end

  def status(token, chat_id, bot, add)
    @@conn.token = token
    bot.api.send_message(chat_id: chat_id, text: @@conn.conn_status(add), parse_mode: 'HTML')
  end
end
