# Untuk memeriksa apakah squad kosong
class Squad
  def empty?(bot, id, squad, com, name)
    @send = SendMessage.new
  
    @send.stg_invalid_format(id, com, name)
    bot.api.send_message(@send.message) if squad.nil? || squad == false
  end
end
  