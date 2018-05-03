class Staging
  attr_reader :bot_staging

  def is_empty?(bot, id, message, command, staging)
    if staging == nil || staging == "" || staging == false
      bot.api.send_message(chat_id: id, text: empty_staging(command, message.from.username), parse_mode: 'HTML')
    end
  end

  def is_bbm?(staging)
    unless staging == "21" || staging == "51" || staging == "103"
      @bot_staging = false
    else
      @bot_staging = true
    end
  end

  def is_booked?(status)
    if status == "booked"
      @bot_staging = true
    else
      @bot_staging = false
    end
  end
end
