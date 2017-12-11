require 'telegram/bot'
require 'envbash'

TOKEN = 'token from botfather'
@chat_id = '-123456789' #ID of your telegram group

Telegram::Bot::Client.run(@token) do |bot|
  bot.listen do |message|
    txt = message.text
    #--------------------
    type_add = txt[1..3]
    bot_name = txt[4..17]
    add_day = txt[5..7]
    add_name = txt[9..-1]
    bot_add_day = txt[19..21]
    bot_add_name = txt[23..-1]
    #--------------------
    type_edit = txt[1..4]
    edit_bot_name = txt[5..18]
    edit_day = txt[6..8]
    edit_name = txt[10..-1]
    bot_edit_day = txt[20..22]
    bot_edit_name = txt[24..-1]
    #--------------------
    done_name = txt[6..-1]
    #--------------------
    type_delete = txt[1..6]
    delete_name = txt[8..-1]
    #--------------------
    type_reminder = txt[1..8]

    if(add_day == "mon" || edit_day == "mon")
      day_name = "Senin"
    elsif(add_day == "tue" || edit_day == "tue")
      day_name = "Selasa"
    elsif(add_day == "wed" || edit_day == "wed")
      day_name = "Rabu"
    elsif(add_day == "thu" || edit_day == "thu")
      day_name = "Kamis"
    elsif(add_day == "fri" || edit_day == "fri")
      day_name = "Jumat"
    else
      day_name = "-"
    end

    if(bot_add_day == "mon" || bot_edit_day == "mon")
      bot_day_name = "Senin"
    elsif(bot_add_day == "tue" || bot_edit_day == "tue")
      bot_day_name = "Selasa"
    elsif(bot_add_day == "wed" || bot_edit_day == "wed")
      bot_day_name = "Rabu"
    elsif(bot_add_day == "thu" || bot_edit_day == "thu")
      bot_day_name = "Kamis"
    elsif(bot_add_day == "fri" || bot_edit_day == "fri")
      bot_day_name = "Jumat"
    else
      bot_day_name = "-"
    end

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

    if(type_add == 'add')
      case message.from.username
      when "a", "b", "c", "d"
        case bot_name
        when "@bot"
          var = ["day="+bot_add_day, "name="+bot_add_name]
          File.open("callruby.rb", "w+") do |f|
            f.puts(var)
          end
          bot.api.send_message(chat_id: @chat_id, text: "Cihuy\n@#{message.from.username} nambahin #{bot_add_name} buat bawa snack di hari #{bot_day_name}")
        else
          var = ["day="+add_day, "name="+add_name]
          File.open("callruby.rb", "w+") do |f|
            f.puts(var)
          end
          bot.api.send_message(chat_id: @chat_id, text: "Cihuy\n@#{message.from.username} nambahin #{add_name} buat bawa snack di hari #{day_name}")
        end
        EnvBash.load('db_add.bash')
      else
        bot.api.send_message(chat_id: message.chat.id, text: "@#{message.from.username}, maap anda belum beruntung :p")
      end
    elsif(type_edit == 'edit')
      case message.from.username
      when "a", "b", "c", "d"
        case edit_bot_name
        when "@bot"
          var = ["day="+bot_edit_day, "name="+bot_edit_name]
          File.open("callruby.rb", "w+") do |f|
            f.puts(var)
          end
          bot.api.send_message(chat_id: @chat_id, text: "Oi oi oi #{bot_edit_name} jadwal snacknya diganti jadi hari #{bot_day_name} yaa")
        else
          var = ["day="+edit_day, "name="+edit_name]
          File.open("callruby.rb", "w+") do |f|
            f.puts(var)
          end
          bot.api.send_message(chat_id: @chat_id, text: "Oi oi oi #{edit_name} jadwal snacknya diganti jadi hari #{day_name} yaa")
        end
        EnvBash.load('db_edit.bash')
      else
        bot.api.send_message(chat_id: message.chat.id, text: "@#{message.from.username}, maap anda belum beruntung :p")
      end
    elsif(type_delete == "delete")
      case message.from.username
      when "a", "b", "c", "d"
        var = ["name="+delete_name]
        File.open("callruby.rb", "w+") do |f|
          f.puts(var)
        end
        EnvBash.load('db_delete.bash')
        bot.api.send_message(chat_id: @chat_id, text: "ByBy #{delete_name}")
      else
        bot.api.send_message(chat_id: message.chat.id, text: "@#{message.from.username}, maap anda belum beruntung :p")
      end
    elsif(type_edit == "done")
      var = ["name="+done_name]
      File.open("callruby.rb", "w+") do |f|
        f.puts(var)
      end
      EnvBash.load('db_check.bash')
      line = File.read('./callruby.rb')
      day = line[4..6]
      if(day == @day.downcase)
        bot.api.send_message(chat_id: @chat_id, text: "Sudah dikonfirmasi ya kawan2 kalau #{done_name} sudah melaksanakan tugas negara.\nSelamat ngemil\n😈")
        EnvBash.load('db_update.bash')
      else
        bot.api.send_message(chat_id: @chat_id, text: "Nice try @#{message.from.username} but useless")
      end
    elsif(type_reminder == "reminder")
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
    elsif(type_edit == "help")
      bot.api.send_message(chat_id: message.chat.id, text: "When you try to add/edit some snack schedule, please read carefully this.
- Day format
only use `mon`, `tue`, `wed`, `thu` or `fri`
example `/add mon @tele_user`")
    end
  end
end