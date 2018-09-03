def new_member(message, bot)
  @db = Connection.new

  unless message.new_chat_members[0].is_bot == true
    @member = "@#{message.new_chat_members[0].username}"
    bot.api.send_message(chat_id: message.chat.id, text: msg_welcome_member(@member, message.chat.title), parse_mode: 'HTML')
    @db.add_hi5('BANDUNG', @member)
  end
rescue StandardError => e
  puts "#{e} no new member in group"
end

def left_member(message, bot)
  @db = Connection.new

  unless message.left_chat_member.is_bot == true
    @member = message.left_chat_member.first_name
    @username = "@#{message.left_chat_member.username}"
    bot.api.send_message(chat_id: message.chat.id, text: msg_left_member(@member), parse_mode: 'HTML')
    @db.delete_member_hi5(@username)
    @db.delete_people(@username)
  end
rescue StandardError => e
  puts "#{e} no left member in group"
end

def check_data(token, id, bot, message, data)
  if data == 'email'
    Bot::Command::Hi5.new(token, id, bot, message, data).member_email
  else
    Bot::Command::Hi5.new(token, id, bot, message, data).hi5_member(data)
  end
end

def define_ip(stg)
  @ip_stg = "staging#{stg}.vm"
  @ip_stg = '192.168.114.182' if stg == '21'
  @ip_stg = '192.168.34.46' if stg == '51'
  @ip_stg = '192.168.35.95' if stg == '103'
end
