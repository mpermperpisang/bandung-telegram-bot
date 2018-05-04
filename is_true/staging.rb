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

  def bbm?(bot, id, stg, user)
    vm = %w[21 51 103]

    bot.api.send_message(chat_id: id, text: errorStaging(user)) unless vm.include?(stg)
  end

  def booked?(bot, id, user, status, name, stg)
    bot.api.send_message(chat_id: id, text: msg_block_deploy(user)) if status == 'done' && name == false
    txt = user.eql?(name) ? msg_still_book(stg, user) : msg_using_staging(name, stg, user)
    bot.api.send_message(chat_id: id, text: txt, parse_mode: 'HTML') if status == 'booked'
  end
end
