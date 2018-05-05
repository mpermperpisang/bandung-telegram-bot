# Untuk memerika apakah branch kosong
class Branch
  def empty?(bot, id, branch, com, name)
    @send = SendMessage.new

    @send.empty_brc(id, com, name)
    bot.api.send_message(@send.message) if branch.nil? || branch == false
  end
end
