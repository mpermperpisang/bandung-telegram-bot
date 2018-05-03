require './helper/bot_status.rb'

<<<<<<< HEAD
# Untuk melihat detail status bot
class ConnectionStatus
  def online(token, chat_id, bot, add)
    @conn = BotStatus.new

    @conn.type_status = :online
=======
class ConnectionStatus
  @@conn = BotStatus.new

  def online(token, chat_id, bot, add)
    @@conn.type_status = :online
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
    status(token, chat_id, bot, add)
  end

  def offline(token, chat_id, bot, add)
<<<<<<< HEAD
    @conn.type_status = :offline
=======
    @@conn.type_status = :offline
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
    status(token, chat_id, bot, add)
  end

  def status(token, chat_id, bot, add)
<<<<<<< HEAD
    @conn.token = token
    bot.api.send_message(chat_id: chat_id, text: @conn.conn_status(add), parse_mode: 'HTML')
=======
    @@conn.token = token
    bot.api.send_message(chat_id: chat_id, text: @@conn.conn_status(add), parse_mode: 'HTML')
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
  end
end
