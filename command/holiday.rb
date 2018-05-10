module Bot
  class Command
    # meliburkan jadwal snack
    class Holiday < Command
      def check_text
        check_user_spam if @txt.start_with?('/holiday')
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        check_admin
      end

      def check_admin
        return if @is_user.admin?(@bot, @id, @username)
        check_empty_people
      end

      def check_empty_people
        @is_snack = Snack.new

        return if @is_snack.empty?(@bot, @id, @username, @symbol, @command)
        check_user_snack
      end

      def check_user_snack
        @db = Connection.new
        @dday = Day.new
        @dday.read_today

        name = @txt.scan(/\B@\S+/)
        name.each do |holi_name|
          holi_name == '@all' ? holi_all : holi_people(holi_name)
        end
      end

      def holi_all
        @db.holiday_all(@dday.hari)
        @bot.api.send_message(chat_id: @id, text: msg_holiday_all)
      end

      def holi_people(name)
        holi_day = @db.check_day(name)
        day = holi_day.size.zero? ? nil : holi_day.first['day']

        if day == @dday.hari
          holi_user = @db.check_people(name)
          name_snack = holi_user.size.zero? ? nil : holi_user.first['name']

          name_snack.nil? ? empty_snack(name_snack) : holi_snack(name_snack)
        else
          Bot::Command::DoneSnack.new(@token, @id, @bot, @message, @txt).reminder_done(name)
        end
      end

      def empty_snack(name)
        @bot.api.send_message(chat_id: @id, text: empty_people(name), parse_mode: 'HTML')
      end

      def holi_snack(name)
        @db.holiday_people(name)
        @bot.api.send_message(chat_id: @id, text: msg_holiday_people(name), parse_mode: 'HTML')
      end
    end
  end
end
