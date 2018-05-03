def new_member(message, bot)
  unless message.new_chat_members[0].is_bot == true
    @member = "@#{message.new_chat_members[0].username}"
    bot.api.send_message(chat_id: @chat_id, text: msg_welcome_member(@member))
    Bot::DBConnect.new.add_hi5("BANDUNG", @member)
  end
rescue
  ""
end

def left_member(message, bot)
  unless message.left_chat_member.is_bot == true
    @member = message.left_chat_member.first_name
    @username = "@#{message.left_chat_member.username}"
    bot.api.send_message(chat_id: @chat_id, text: msg_left_member(@member))
    Bot::DBConnect.new.delete_member_hi5(@username)
    Bot::DBConnect.new.delete_people(@username)
  end
rescue
  ""
end
