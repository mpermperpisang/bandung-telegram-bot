class Snack
  def is_empty?(bot, id, message, snack, command)
    if snack == nil || snack == ""
      bot.api.send_message(chat_id: id, text: empty_snack(command, message.from.username), parse_mode: 'HTML')
    end
  end
end
