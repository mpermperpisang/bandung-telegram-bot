require 'telegram/bot'
require 'mysql2'

token = '494935542:AAGQyOrPbfXTXmD8QIERaZgnSQS_nyvx1HM'
#token = '593318700:AAEXId1YyRFZZzvfoHJb5RKtcHReeLh7mCY'
#@chat_id = '-1001479782294' #testing bot local
#@chat_id = '-317359831' #testing bot staging
#@chat_id = '-148800628' #Bukalapak.bdg
@chat_id = '-1001251178097'

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

@client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "bukalapak")
@client.query("use bbm_squad")

File.open('./require_ruby.rb', 'w+') do |f|
	@client.query("SELECT name FROM bandung_snack where day='#{@day.downcase}' and (status='sudah' or status='belum')").each do |row|
		f.puts("i#{row}")
	end
end

list = File.read('./require_ruby.rb')
line = list.gsub('{"name"=>"','')
@name = line.gsub('"}','')

bot.api.send_message(chat_id: @chat_id, text: "Hari #{@snack}. Sudahkah Kakak membawa snack sehat? 😊\n\n*Format baru reminder snack akan dikirimkan by japri. Yuk japri aku dan ketik <code>/done</code>", parse_mode: 'HTML') unless @name.nil? || @name.empty? || @name == ""

=begin
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
    bot.api.send_message(chat_id: @chat_id, text: "Ayoyo ojo lali. Daftar yang belum bawa hari #{@snack}\n#{name}\n\n*minimum snack/orang Rp. 20000 yaa, Kak 😘")
  end
end
=end
