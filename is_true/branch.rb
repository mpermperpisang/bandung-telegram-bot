class Branch
  def is_empty?(bot, id, message, branch, command, name)
    if branch == nil || branch == "" || branch == "@" || branch == "@#{ENV['BOT_BOOKING']}" || branch == "@#{ENV['BOT_JENKINS']}"
      bot.api.send_message(chat_id: id, text: empty_branch(command, name), parse_mode: 'HTML')
    end
  end
end
