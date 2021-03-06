require 'telegram/bot'
require 'mysql2'

token = ENV['TOKEN_SNACK']
@chat_id = ENV['ID_SNACK']

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
  @client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "password")
  @client.query("use bbm_squad")
  
  begin
    @from_member = @client.query("select from_id from bandung_snack where day='#{@day.downcase}' and status='belum'")
    @from_all = @client.query("select from_id from bandung_snack")
    @list_member = @client.query("select name from bandung_snack where day='#{@day.downcase}' and (from_id='' or from_id is null) and status='belum'")
    
    @array = []
    
    @list_member.each do |member|
	  @array.push("#{member['name']}")
	end
	
	@list = @array.to_s.gsub('", "', ", ").delete('["').delete('"]')
  
    @from_member.each do |snack|
  	  @member_id = snack['from_id']
  	
      File.open('./require_ruby.rb', 'w+') do |f|
	    @client.query("SELECT name FROM bandung_snack where day='#{@day.downcase}' and status='belum'").each do |row|
	      f.puts(row)
	    end
	  end
	
	  @client.query("update bandung_snack set status='belum' where day<>'#{@day.downcase}'")
	  @client.query("update bot_spam set bot_attempt='0' where bot_command<>''")
	  list = File.read('./require_ruby.rb')
	  line = list.gsub('{"name"=>"','')
	  @name = line.gsub('"}','')
	
    case @name
	  when nil, ""
	    File.open('./require_ruby.rb', 'w+') do |f|
	      @client.query("SELECT name FROM bandung_snack where day='#{@day.downcase}' and status='sudah'").each do |row|
	        f.puts("i#{row}")
	      end
	    end
	
	    list = File.read('./require_ruby.rb')
	    line = list.gsub('{"name"=>"','')
	    name = line.gsub('"}','')
	    
	    @from_all.each do |all|
	      @all_id = all['from_id']
   	      bot.api.send_message(chat_id: @all_id, text: "Hi Kak, udah ngemil cakep hari ini? Yuk intip di meja snack ada apa ajah karena semua sudah bawa snacknya 😙") unless name.nil? || name == "" || @all_id.nil? || @all_id.empty? || @all_id == ""
   	    end
	  else
	    bot.api.send_message(chat_id: @member_id, text: "Belum bawa snack yaa, Kak? Jadwal Kakak hari ini loh.\nDitunggu yaa dan jangan lupa klik /done (<code>/done</code> <b>HANYA BISA VIA PRIVATE MESSAGE</b>) 😘\n\n*minimum snack/orang Rp. 20000 yaa, Kak", parse_mode: 'HTML') unless @member_id.nil? || @member_id.empty? || @member_id == "" || @member_id == "103443335" || @member_id == "284392817"
	  end
	end
	
	bot.api.send_message(chat_id: @chat_id, text: "Untuk Kakakku tersayang (#{@list}. Kalau sudah bawa snacknya harap lakukan step-step ini yaa)
	  
1. Japri aku
2. Plis <code>/done</code> via private message ☺️", parse_mode: 'HTML') unless @name.nil? || @name == "" || @list.nil? || @list == ""
  rescue StandardError => e
	puts e
	puts @member_id
	  
	if @list_member.size.zero?
	  bot.api.send_message(chat_id: @chat_id, text: "Halo Kakak-kakak, mau ngingetin ajah nih.

1. Japri aku dan klik Start atau ketik /start
2. Jangan blokir aku biar aku bisa ngirim private message ke kalian 😉")
    end
  end
end
