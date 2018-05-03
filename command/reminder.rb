module Bot
  class Command
    class Reminder < Command
      @@dday = Day.new
      @@reminder = BandungSnack.new
      @@user = User.new

      def reminder_snack
        @@user.is_spammer?(@bot, @id, @message.from.username, @message, @command)
        if @@user.spam == false
          @@dday.read_today

          @kb = [[Telegram::Bot::Types::InlineKeyboardButton.new(text: "Senin", callback_data: "mon"),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: "Selasa", callback_data: "tue"),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: "Rabu", callback_data: "wed")],
          [Telegram::Bot::Types::InlineKeyboardButton.new(text: "Kamis", callback_data: "thu"),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: "Jumat", callback_data: "fri")]]
          markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @kb)

          if(@@dday.snack == 'Libur')
            @bot.api.send_message(chat_id: @id, text: msg_holiday(@message.from.username))
            @bot.api.send_message(chat_id: @message.from.id, text: "Lihat jadwal snack", reply_markup: markup)
          else
            reminder = Bot::DBConnect.new.remind_people(@@dday.hari)

            if reminder == nil || reminder.empty?
              day_name = nil
            else
              day_name = File.open("./require_ruby.rb", "w+") do |f|
                reminder.each do |row|
                  f.puts(row['name'])
                end
              end
            end
            
            Bot::DBConnect.new.reset_reminder(@@dday.hari)

            case day_name
            when nil, ""
              holiday = Bot::DBConnect.new.people_holiday(@@dday.hari)
              holi_name = holiday.empty? ? nil : holiday[0]['name']

              case holi_name
              when nil, ""
                @bot.api.send_message(chat_id: @id, text: holiday_schedule)
              else
                @bot.api.send_message(chat_id: @id, text: empty_schedule)
                @bot.api.send_message(chat_id: @message.from.id, text: "Lihat jadwal snack", reply_markup: markup)
              end
            else
              list_snack = File.read('./require_ruby.rb')
              @bot.api.send_message(chat_id: @id, text: msg_reminder_people(@@dday.snack, list_snack, @message.from.username), parse_mode: 'HTML')
              @bot.api.send_message(chat_id: @message.from.id, text: "Lihat jadwal snack", reply_markup: markup)
            end
          end
        end
      end
    end
  end
end
