class Chat
  def delete(bot, id, msg_id)
    begin
      bot.api.delete_message(chat_id: id, message_id: msg_id)
    rescue
      ""
    end
  end
end
