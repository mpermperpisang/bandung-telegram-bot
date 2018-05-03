# Untuk memerika apakah branch kosong
class Branch
  def empty?(bot, id, branch, command, name)
    @sendmessage = {
      chat_id: id,
      text: empty_branch(command, name),
      parse_mode: 'HTML'
    }
    bot.api.send_message(@sendmessage) if branch.nil?
  end
end
