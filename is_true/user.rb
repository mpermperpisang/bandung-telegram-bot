require './message/message_text.rb'
# Untuk membedakan berbagai jenis pengguna bot
class User
  attr_reader :spam

  def developer?(bot, id, user)
    @msg = MessageText.new
    @msg.bot_user
    @msg.quality_assurance

    qa = @msg.dana_qa
    bot.api.send_message(chat_id: id, text: error_dev(user)) if qa.include?(user)
  end

  def quality_assurance?(bot, id, user, txt)
    @msg = MessageText.new
    @msg.read_text(txt)
    @msg.quality_assurance

    qa = @msg.qa
    bot.api.send_message(chat_id: id, text: error_qa(user)) unless qa.include?(user)
  end

  def admin?(bot, id, user)
    @msg = MessageText.new
    @msg.bot_user
    @msg.quality_assurance

    admin = @msg.admin
    bot.api.send_message(chat_id: id, text: error_admin(user)) unless admin.include?(user)
  end

  def pm?(bot, id, user)
    @msg = MessageText.new
    @msg.bot_user
    @msg.quality_assurance

    pm = @msg.pm
    bot.api.send_message(chat_id: id, text: error_pm(user)) unless pm.include?(user)
  end

  def spammer?(bot, id, user, message, data)
    @msg = MessageText.new
    @msg.bot_user
    @msg.quality_assurance

    admin = @msg.admin
    squad = @msg.squad
    grup_id = squad.include?(data) ? message.from.id : id

    check_spammer(admin, bot, user, data, grup_id)
  end
end
