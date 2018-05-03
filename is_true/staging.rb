# Untuk memeriksa apakah staging kosong, milik bbm dan sudah terbooking
class Staging
  attr_reader :bot_staging

  def empty?(bot, id, staging, user, txt)
    @sendmessage = {
      chat_id: id,
      text: empty_staging(txt, user),
      parse_mode: 'HTML'
    }
    bot.api.send_message(@sendmessage) if staging.nil? || staging == false
  end

  def bbm?(staging)
    vm = %w[21 51 103]

    @bot_staging = true if vm.include?(staging)
  end

  def booked?(bot, id, user, status)
    bot.api.send_message(chat_id: id, text: msg_block_deploy(user)) if status == 'done'
  end
end
