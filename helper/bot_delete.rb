# untuk menghapus chat di grup
class Chat
  def delete(bot, id, msg_id)
    bot.api.delete_message(chat_id: id, message_id: msg_id)
  rescue StandardError => e
    puts e
  end
end
