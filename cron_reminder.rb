require 'telegram/bot'
require 'envbash'

TOKEN = 'token from botfather'
@chat_id = '-123456789' #ID of your telegram group
bot = Telegram::Bot::Client.new(TOKEN)
@today = Date.today
@day = @today.strftime("%a")

case @day
when "Mon"
  @snack = "Senin"
when "Tue"
  @snack = "Selasa"
when "Wed"
  @snack = "Rabu"
when "Thu"
  @snack = "Kamis"
when "Fri"
  @snack = "Jumat"
else
  @snack = "Libur"
end
  
var = ["day=#{@day.downcase}"]
File.open("callruby.rb", "w+") do |f|
    f.puts(var)
end
if(@snack == 'Libur')
    bot.api.send_message(chat_id: @chat_id, text: "Libur eceu -_-")
else
  EnvBash.load('db_list.bash')
  line = File.read('./callruby.rb')
  name = line[4..-1]
  case name
  when nil, ""
    bot.api.send_message(chat_id: @chat_id, text: "Yeay banyak cemilan.\nSelamat menggendutkan diri, kawan-kawan\n😈")
  else
    bot.api.send_message(chat_id: @chat_id, text: "Ayoyo ojo lali. Daftar yang belum bawa hari #{@snack}\n#{name}\n\n*yang merasa belum diwajibkan untuk membawa snake, abaikan saja pesan ini")
  end
end