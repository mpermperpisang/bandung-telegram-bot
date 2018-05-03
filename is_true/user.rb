require './message/message_text.rb'
# Untuk membedakan berbagai jenis pengguna bot
class User
  attr_reader :spam

  def developer?(bot, id, user)
    qa = @msg.dana_qa
    bot.api.send_message(chat_id: id, text: errorDev(user)) if qa.include?(user)
  end

  def quality_assurance?(bot, id, user, txt)
    @msg = MessageText.new
    @msg.read_text(txt)
    @msg.quality_assurance

    qa = @msg.qa
    bot.api.send_message(chat_id: id, text: errorQA(user)) unless qa.include?(user)
  end

  def admin?(bot, id, user)
    admin = @msg.admin
    bot.api.send_message(chat_id: id, text: errorAdmin(user)) unless admin.include?(user)
  end

  def pm?(bot, id, user)
    pm = @msg.pm
    bot.api.send_message(chat_id: id, text: errorPM(user)) unless pm.include?(user)
  end

  def spammer?(bot, id, user, message, data)
    admin = @msg.admin
    squad = @msg.squad
    grup_id = squad.include?(data) ? message.from.id : id

    check_spammer(admin, bot, user, data, grup_id)
  end
end
