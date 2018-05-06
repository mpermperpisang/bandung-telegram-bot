module Bot
  class Command
    # untuk mengubah jadwal snack sementara
    class Edit < Command
      def check_text
        check_user_spam if @txt.start_with?('/edit')
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
        @msg = MessageText.new
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

        check_user = @db.check_people(@symbol)
        name = check_user.size.zero? ? nil : check_user.first['name']

        name.nil? ? empty_snack : edit_snack
      end

      def edit_snack
        @dday = Day.new

        @dday.read_day(@space)
        @db.edit_people(@space, @symbol)
        @bot.api.send_message(chat_id: @id, text: msg_edit_people(@username, @symbol, @dday.day_name), parse_mode: 'HTML')
      end

      def empty_snack
        @bot.api.send_message(chat_id: @id, text: empty_people(@symbol), parse_mode: 'HTML')
      end
    end
  end
end
