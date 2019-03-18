module Bot
  class Command
    # jika sudah bawa snack
    class DoneSnack < Command
      def check_text
        check_user_spam if @txt.start_with?('/done')
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        check_user_snack
      end

      def check_user_snack
        @db = Connection.new
        @dday = Day.new

        @name = @symbol.nil? ? "@#{@username}" : @symbol
        day_name = @db.check_day(@name)
        @day = day_name.size.zero? ? nil : day_name.first['day']
        @dday.read_today

        @day.eql?(@dday.hari) ? update_done : reminder_done(@name)
      end

      def update_done
        user = @db.check_done(@name)
        status = user.size.zero? ? nil : user.first['status']

        case status
        when 'sudah'
          @bot.api.send_message(chat_id: @id, text: msg_done_spam(@username, @name), parse_mode: 'HTML')
        when 'libur'
          @bot.api.send_message(chat_id: @id, text: msg_holiday_spam(@username, @name), parse_mode: 'HTML')
        when 'belum'
          @db.done_people(@day, @name, @fromid)
          @bot.api.send_message(chat_id: ENV['ID_SNACK'], text: msg_done_people(@name))
        end
      end

      def reminder_done(name)
        @db = Connection.new
        @dday = Day.new

        day_name = @db.check_day(name)
        @day = day_name.size.zero? ? nil : day_name.first['day']
        @name = name

        user = @db.check_people(@name)
        reminder_name = user.size.zero? ? nil : user.first['name']

        reminder_name.nil? ? empty_snack : reminder_snack
      end

      def empty_snack
        @bot.api.send_message(chat_id: @id, text: empty_people(@name), parse_mode: 'HTML')
      end

      def reminder_snack
        @bot.api.send_message(chat_id: @id, text: msg_reminder_schedule(@dday.read_day(@day), @name))
      end
    end
  end
end
