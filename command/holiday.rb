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

        @array = []

        @name = @txt.scan(/\B@\S+/)
        @name.each do |holi_name|
          unless (holi_name == '@all') || (@array.include? holi_name)
            @array.push(holi_name)
          end
        end
        @array.empty? ? holi_all : holi_people
      end

      def holi_all
        @db.holiday_all(@dday.hari)
        @bot.api.send_message(chat_id: @id, text: msg_holiday_all)
      end

      def holi_people
        @arr_name = []

        @array.each do |holi_name|
          holi_day = @db.check_day(holi_name)
          day = holi_day.size.zero? ? nil : holi_day.first['day']

          if day == @dday.hari
            holi_user = @db.check_people(holi_name)
            @name_snack = holi_user.size.zero? ? nil : holi_user.first['name']
            @arr_name.push(holi_name) unless @name_snack.nil?
          else
            Bot::Command::DoneSnack.new(@token, @id, @bot, @message, @txt).reminder_done(holi_name)
          end
        end

        holi_snack unless @arr_name.empty?
      end

      def holi_snack
        @arr_name.each do |holi_name|
          @db.holiday_people(holi_name)
        end

        @list = @arr_name.to_s.delete('["').delete('"]').gsub('", "', ', ')
        @bot.api.send_message(chat_id: @id, text: msg_holiday_people(@list), parse_mode: 'HTML')
      end
    end
  end
end
