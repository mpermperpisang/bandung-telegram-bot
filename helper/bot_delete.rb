<<<<<<< HEAD
# untuk menghapus chat di grup
class Chat
  def delete(bot, id, msg_id)
    bot.api.delete_message(chat_id: id, message_id: msg_id)
  rescue StandardError => e
    puts e
=======
class Chat
  def delete(bot, id, msg_id)
    begin
      bot.api.delete_message(chat_id: id, message_id: msg_id)
    rescue
      ""
    end
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
  end
end
