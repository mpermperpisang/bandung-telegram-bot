module Bot
  class Command
    # mengubah jadwal snack secara permanent, dan harus mengubah confluence juga
    class Change < Command
      def check_text
        check_user_spam if @txt.start_with?('/move')
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        check_admin
      end

      def check_admin
        return if @is_user.admin?(@bot, @id, @username)
        check_empty_day
      end

      def check_empty_day
        @send = SendMessage.new

        @send.err_day_snack(@id, @command)
        @msg.weekdays

        day = @space.nil? ? nil : @space.strip
        if @symbol.nil? || @msg.days.none? { |n| n == day }
          @bot.api.send_message(@send.message)
        else
          check_user_snack
        end
      end

      def check_user_snack
        @db = Connection.new

        @dday = @txt.scan(/\s[a-zA-Z0-9]{0}[a-zA-Z][^\s]+\s@[a-z^]+/)

        @dday.each do |day_name|
          day = day_name[/\s[a-zA-Z0-9]{0}[a-zA-Z][^\s]+/]
          move_name = day_name[/\B@\S+/]

          check_user = @db.check_people(move_name)
          @snack_name = check_user.size.zero? ? nil : check_user.first['name']

          @snack_name.nil? ? empty_snack(name) : change_snack(day, move_name)
        end
      end

      def empty_snack(name)
        @bot.api.send_message(chat_id: @id, text: empty_people(name), parse_mode: 'HTML')
      end

      def change_snack(day, name)
        @dday = Day.new

        @dday.read_day(day)
        @db.change_people(day, name)
        @bot.api.send_message(chat_id: @id, text: msg_change_people(@username, name, @dday.day_name), parse_mode: 'HTML')
      end
    end
  end
end
