<<<<<<< HEAD
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
=======
class Staging
  attr_reader :bot_staging

  def is_empty?(bot, id, message, command, staging)
    if staging == nil || staging == "" || staging == false
      bot.api.send_message(chat_id: id, text: empty_staging(command, message.from.username), parse_mode: 'HTML')
    end
  end

  def is_bbm?(staging)
    unless staging == "21" || staging == "51" || staging == "103"
      @bot_staging = false
    else
      @bot_staging = true
    end
  end

  def is_booked?(status)
    if status == "booked"
      @bot_staging = true
    else
      @bot_staging = false
    end
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
  end
end
