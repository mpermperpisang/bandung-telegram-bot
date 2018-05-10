module Bot
  class Command
    # untuk mengingatkan jadwal snack kalau cronjobnya bermasalah
    class Reminder < Command
      def check_text
        check_user_spam if @txt.start_with?('/reminder')
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        check_schedule
      end

      def remind_schedule
        key_day
        @markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @kb)
      end

      def check_schedule
        @dday = Day.new

        @dday.read_today
        remind_schedule
        @dday.snack == 'Libur' ? weekend_snack : weekdays_snack
      end

      def weekend_snack
        @bot.api.send_message(chat_id: @id, text: msg_holiday(@message.from.username))
        @bot.api.send_message(chat_id: @message.from.id, text: see_schedule, reply_markup: @markup)
      end

      def weekdays_snack
        @db = Connection.new

        @reminder = @db.remind_people(@dday.hari)

        day_name = @reminder.size.zero? ? nil : open_file

        @db.reset_reminder(@dday.hari)

        day_name.nil? ? empty_snack : list_snack
        @bot.api.send_message(chat_id: @fromid, text: see_schedule, reply_markup: @markup)
      end

      def open_file
        File.open('./require_ruby.rb', 'w+') do |f|
          @reminder.each do |row|
            f.puts(row['name'])
          end
        end
      end

      def empty_snack
        holiday = @db.people_holiday(@dday.hari)
        holi_name = holiday.size.zero? ? nil : holiday.first['name']
        msg_empty_snack = holi_name.nil? ? holiday_schedule : empty_schedule

        @bot.api.send_message(chat_id: @id, text: msg_empty_snack)
      end

      def list_snack
        @send = SendMessage.new

        list_snack = File.read('./require_ruby.rb')
        @send.remind_snack(@id, @dday.snack, list_snack, @username)
        @bot.api.send_message(@send.message)
      end
    end
  end
end
