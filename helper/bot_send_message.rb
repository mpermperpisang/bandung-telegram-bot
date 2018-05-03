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
end
