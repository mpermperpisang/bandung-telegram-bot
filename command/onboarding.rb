def onboarding(message, bot)
  @db = Connection.new
  
  @txt = message.text
  
  @array = []

  check_member = @db.check_onboarding("@#{message.from.username}")
  @check = check_member.size.zero? ? nil : check_member.first['on_flag']

  if @txt[/^(.*(?=Nama panggilan :).*[a-zA-Z.,&()]\n.*(?=Job title :).*[a-zA-Z.,&()]\n.*(?=Squad :).*[a-zA-Z.,&()]\n(.*(?=Pekerjaan :).*[a-zA-Z0-9.,&()]\n|.*(?=Pendidikan :).*[a-zA-Z0-9.,&()]\n|.*(?=Pendidikan terakhir :).*[a-zA-Z0-9.,&()]\n|.*(?=Pekerjaan terakhir :).*[a-zA-Z0-9.,&()]\n|.*(?=Pekerjaan atau Pendidikan terakhir :).*[a-zA-Z0-9.,&()]\n).*(?=Status :).*[a-zA-Z.,&()]\n.*(?=Hobi :).*[a-zA-Z.,&()]\n.*(?=Motto :).*[a-zA-Z.,&()])$/] != nil
     @db.done_onboarding(message.from.username)
     bot.api.send_message(chat_id: ENV['ID_REMINDER'], text: msg_welcome_new_member(message.from.first_name, message.from.username), parse_mode: 'HTML') if @check == "false"
     bot.api.send_message(chat_id: ENV['ID_REMINDER'], text: "Berikut perkenalan dari Kak @#{message.from.username}\n\n#{@txt}", parse_mode: 'HTML') if @check == "false"
     bot.api.send_message(chat_id: message.from.id, text: input_buka_bandung, parse_mode: 'HTML') if @check == "false"
     @chat.delete(bot, message.chat.id, message.message_id) if @check == "true" or @check.nil?
  end

  @array.push('Nama panggilan') if @txt[/^(.*(?=Nama panggilan :).*[a-zA-Z.,&()])$/].nil?
  @array.push('Job title') if @txt[/^(.*(?=Job title :).*[a-zA-Z.,&()])$/].nil?
  @array.push('Squad') if @txt[/^(.*(?=Squad :).*[a-zA-Z.,&()])$/].nil?
  @array.push('Pekerjaan atau Pendidikan terakhir') if @txt[/^(.*(?=Pekerjaan :).*[a-zA-Z0-9.,&()]\n|.*(?=Pendidikan :).*[a-zA-Z0-9.,&()]\n|.*(?=Pekerjaan terakhir :).*[a-zA-Z0-9.,&()]\n|.*(?=Pendidikan terakhir :).*[a-zA-Z0-9.,&()]\n|.*(?=Pekerjaan atau Pendidikan terakhir :).*[a-zA-Z0-9.,&()])$/].nil?
  @array.push('Status') if @txt[/^(.*(?=Status :).*[a-zA-Z.,&()])$/].nil?
  @array.push('Hobi') if @txt[/^(.*(?=Hobi :).*[a-zA-Z.,&()])$/].nil?
  @array.push('Motto') if @txt[/^(.*(?=Motto :).*[a-zA-Z.,&()])$/].nil?

  check_member = @db.check_onboarding("@#{message.from.username}")
  @check = check_member.size.zero? ? nil : check_member.first['on_flag']

  @list = @array.to_s.gsub('", "', ", ").delete('["').delete('"]')
  unless @array.empty? && @check.nil?
    bot.api.send_message(chat_id: message.from.id, text: msg_onboarding(message.from.username, @list), parse_mode: 'HTML') if @check == "false"
  end
end
