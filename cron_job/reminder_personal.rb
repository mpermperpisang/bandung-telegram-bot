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

if(@snack != 'Libur')
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "bukalapak")
  client.query("use bbm_squad")
  
  begin
    @from_member = client.query("select from_id from bandung_snack where day='#{@day.downcase}'")
    @from_all = client.query("select from_id from bandung_snack")
  
    @from_member.each do |day|
  	  @id = day['from_id']
  	
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
	    
	    @from_all.each do |all|
	      @all_id = all['from_id']
   	      bot.api.send_message(chat_id: @all_id, text: "Hi Kak, udah ngemil cakep hari ini? Yuk intip di meja snack ada apa ajah karena semua sudah bawa snacknya 😙") unless name.nil? || name == ""
   	    end
	  else
	    bot.api.send_message(chat_id: @id, text: "Belum bawa snack yaa, Kak? Jadwal Kakak hari ini loh. Ditunggu yaa <code>/done</code> nya 😘\n\n*minimum snack/orang Rp. 20000 yaa, Kak", parse_mode: 'HTML')
	  end
	rescue StandardError => e
	  puts e
	  @list_member = client.query("select name from bandung_snack where day='#{@day.downcase}' and (from_id='' or from_id is null)")
	  
	  @array = []
	  
	  @list_member.each do |member|
	  	@array.push("#{member['name']}")
	  end
	  
	  @list = @array.to_s.gsub('", "', ", ").delete('["').delete('"]')
	  bot.api.send_message(chat_id: @chat_id, text: "Untuk Kakakku tersayang (#{@list})
	  
Tolong jangan blokir aku yaa. Aku mau japri loh padahal 😢 (plis <b>/(slash)done</b> juga yaa)", parse_mode: 'HTML')
	end
  end
end
