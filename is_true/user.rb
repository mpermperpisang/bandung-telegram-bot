require './message/message_text.rb'
# Untuk membedakan berbagai jenis pengguna bot
class User
  attr_reader :spam

  def developer?(bot, id, user)
    @msg = MessageText.new
    @msg.quality_assurance

    blqa = @msg.qa
    bot.api.send_message(chat_id: id, text: error_dev(user)) if blqa.include?(user)
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
    @msg.bot_squad

    count_spam = check_spammer(user, data)
    @attempt = count_spam.size.zero? ? nil : count_spam.first['bot_attempt']

    @count = @msg.admin.include?(user) ? 100 : 1
    @last_count = @count + 1

    check_user_spam(bot, id, user, message, data)
    save_spammer(user, data)
  end

  def check_user_spam(bot, id, user, msg, data)
    if (@attempt.to_i >= 0 && @attempt.to_i <= @count) || @attempt == '' || @attempt.nil?
      @spam = false
    elsif @attempt.to_i == @last_count
      @spam = true

      @idchat = @msg.squad.include?(data) ? msg.from.id : id

      bot.api.send_message(chat_id: @idchat, text: error_spam(user))
    else
      @spam = true
    end
  end
end
