# default untuk send message bot
class SendMessage
  attr_reader :message

  def err_deploy_chat(chatid, user, stg, name)
    @message = {
      chat_id: chatid,
      text: error_deploy(user, stg, name),
      parse_mode: 'HTML'
    }
  end

  def err_deploy_from(fromid, user, stg, name)
    @message = {
      chat_id: fromid,
      text: error_deploy(user, stg, name),
      parse_mode: 'HTML'
    }
  end

  def empty_deploy(id, user)
    @message = {
      chat_id: id,
      text: empty_deployment(user)
    }
  end

  def check_new_staging(id, user, stg)
    @message = {
      chat_id: id,
      text: new_staging(user, stg),
      parse_mode: 'HTML'
    }
  end

  def queue_deployment(id, user, stg, branch, name, queue)
    @message = {
      chat_id: id,
      text: msg_queue_deploy(user, stg, branch, name, queue),
      parse_mode: 'HTML'
    }
  end

  def check_empty_staging(id, txt, user)
    @message = {
      chat_id: id,
      text: empty_staging(txt, user),
      parse_mode: 'HTML'
    }
  end

  def success_normalize_date(id, stg, date, time)
    @message = {
      chat_id: id,
      text: normalize(stg, "#{date} #{time}"),
      parse_mode: 'HTML'
    }
  end

  def empty_brc(id, com, name)
    @message = {
      chat_id: id,
      text: empty_branch(com, name),
      parse_mode: 'HTML'
    }
  end
  
  def stg_invalid_format(id, com, name)
  	@message = {
      chat_id: id,
      text: msg_format_add_stg(com, name),
      parse_mode: 'HTML'
    }
  end

  def err_day_snack(id, com)
    @message = {
      chat_id: id,
      text: error_day(com),
      parse_mode: 'HTML'
    }
  end

  def remind_snack(id, day, list, user)
    @message = {
      chat_id: id,
      text: msg_reminder_people(day, list, user),
      parse_mode: 'HTML'
    }
  end

  def day_schedule(id, name, count, amount)
    @message = {
      chat_id: id,
      text: list_schedule(name, count, amount),
      parse_mode: 'HTML'
    }
  end

  def done_status(id, name, stg)
    @message = {
      chat_id: id,
      text: msg_done_staging(name, stg),
      parse_mode: 'HTML'
    }
  end
end
