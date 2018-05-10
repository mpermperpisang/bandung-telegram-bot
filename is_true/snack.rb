# untuk mengecek apakah username snack kosong atau tidak
class Snack
  def empty?(bot, id, user, snack, com)
    bot.api.send_message(chat_id: id, text: empty_snack(com, user), parse_mode: 'HTML') if snack.nil? || snack == false
  end
end
