def new_member(message, bot)
  @db = Connection.new

  unless message.new_chat_members[0].is_bot == true
    @member = "@#{message.new_chat_members[0].username}"
    @db.add_hi5('BANDUNG', @member)
    check_user = @db.check_onboarding(@member)
    new_member = check_user.size.zero? ? nil : check_user.first['on_username']
    if new_member.nil?
      @db.hi_new_member(@member)
    else
      @db.update_new_member(@member)
    end
    bot.api.send_message(chat_id: message.chat.id, text: msg_welcome_member(@member, message.chat.title), parse_mode: 'HTML')
    bot.api.send_message(chat_id: message.new_chat_members[0].id, text: onboarding_member(@member), parse_mode: 'HTML')
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
    @db.delete_admin(@username)
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
  @ip_stg = '192.168.42.129' if stg == '51'
  @ip_stg = '192.168.35.95' if stg == '103'
end
