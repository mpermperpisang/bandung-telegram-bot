# untuk mengecek apakah ada plat kendaraan
class Vehicle
  def empty?(bot, id, user, number)
    bot.api.send_message(chat_id: id, text: empty_vehicle(user), parse_mode: 'HTML') if number.nil? || number == false
  end

  def add_empty?(bot, id, user, number)
    bot.api.send_message(chat_id: id, text: add_empty_vehicle(user), parse_mode: 'HTML') if number.nil? || number == false
  end
end
