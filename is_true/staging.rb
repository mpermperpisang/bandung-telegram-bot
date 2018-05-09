# Untuk memeriksa apakah staging kosong, milik bbm dan sudah terbooking
class Staging
  attr_reader :bot_staging

  def empty?(bot, id, stg, user, txt)
    @msg = MessageText.new
    @msg.read_text(txt)
    @send = SendMessage.new

    @send.check_empty_staging(id, txt, user)
    bot.api.send_message(@send.message) if stg.nil? || stg == false
  end

  def booked?(bot, id, user, status)
    bot.api.send_message(chat_id: id, text: msg_block_deploy(user)) if status == 'done'
  end

  def done?(bot, id, user, status, name, stg)
    text_booking = user.eql?(name) ? msg_still_book(stg, user) : msg_using_staging(name, stg, user)
    bot.api.send_message(chat_id: id, text: text_booking, parse_mode: 'HTML') if status == 'booked'
  end
end
