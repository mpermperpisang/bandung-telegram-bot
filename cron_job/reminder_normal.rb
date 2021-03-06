require 'telegram/bot'
require 'mysql2'

token = ENV['TOKEN_SNACK']
@chat_id = ENV['ID_SNACK']

bot = Telegram::Bot::Client.new(token)
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "password")
    client.query("use bbm_squad")
    client.query("update bandung_snack set day='mon' where fix_day<>day and name<>'' and fix_day='mon'")
    client.query("update bandung_snack set day='tue' where fix_day<>day and name<>'' and fix_day='tue'")
    client.query("update bandung_snack set day='wed' where fix_day<>day and name<>'' and fix_day='wed'")
    client.query("update bandung_snack set day='thu' where fix_day<>day and name<>'' and fix_day='thu'")
    client.query("update bandung_snack set day='fri' where fix_day<>day and name<>'' and fix_day='fri'")
  bot.api.send_message(chat_id: @chat_id, text: "Snack sudah kembali sesuai dengan jadwal di <a href='https://bit.ly/2FBKhA4'>CONFLUENCE</a> yaa", parse_mode: 'HTML')
