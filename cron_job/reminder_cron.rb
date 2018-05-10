require 'telegram/bot'
require 'mysql2'

token = '494935542:AAFNlMJbldeNp8KouAdk42b8Ut4WDv312l4'
#@chat_id = '-192957413' #testing bot local
#@chat_id='-317359831' #testing bot staging
@chat_id='-148800628' #TeleTubis

bot = Telegram::Bot::Client.new(token)
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
File.open("./require_ruby.rb", "w+") do |f|
    f.puts(var)
end
if(@snack == 'Libur')
    bot.api.send_message(chat_id: @chat_id, text: "Libur eceu 😒")
else
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "bukalapak")
  client.query("use bbm_squad")

  File.open('./require_ruby.rb', 'w+') do |f|
    client.query("SELECT name FROM bandung_snack where day='#{@day.downcase}' and status='belum'").each do |row|
      f.puts(row)
    end
  end

  client.query("update bandung_snack set status='belum' where day<>'#{@day.downcase}'")
  client.query("update bot_spam set bot_attempt='0' where bot_command<>''")
  list = File.read('./require_ruby.rb')
  line = list.gsub('{"name"=>"','')
  name = line.gsub('"}','')
  
  case name
  when nil, ""
    File.open('./require_ruby.rb', 'w+') do |f|
      client.query("SELECT name FROM bandung_snack where day='#{@day.downcase}' and status='sudah'").each do |row|
        f.puts("i#{row}")
      end
    end

    list = File.read('./require_ruby.rb')
    line = list.gsub('{"name"=>"','')
    name = line.gsub('"}','')

    case name
    when nil, ""
      bot.api.send_message(chat_id: @chat_id, text: "Libur telah tiba\nHatiku gembira ⛱🏖🏝")
    else
      bot.api.send_message(chat_id: @chat_id, text: "Yeay banyak cemilan.\nSelamat menggendutkan diri, kawan-kawan\n😈")
    end
  else
    bot.api.send_message(chat_id: @chat_id, text: "Ayoyo ojo lali. Daftar yang belum bawa hari #{@snack}\n#{name}\n\n*yang merasa belum diwajibkan untuk membawa snake, abaikan saja pesan ini")
  end
end
