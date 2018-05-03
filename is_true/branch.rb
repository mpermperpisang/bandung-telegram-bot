<<<<<<< HEAD
# Untuk memerika apakah branch kosong
class Branch
  def empty?(bot, id, branch, command, name)
    @sendmessage = {
      chat_id: id,
      text: empty_branch(command, name),
      parse_mode: 'HTML'
    }
    bot.api.send_message(@sendmessage) if branch.nil?
=======
class Branch
  def is_empty?(bot, id, message, branch, command, name)
    if branch == nil || branch == "" || branch == "@" || branch == "@#{ENV['BOT_BOOKING']}" || branch == "@#{ENV['BOT_JENKINS']}"
      bot.api.send_message(chat_id: id, text: empty_branch(command, name), parse_mode: 'HTML')
    end
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
  end
end
