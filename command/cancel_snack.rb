module Bot
  class Command
    # membatalkan seseorang membawa snack jika berbohong
    class CancelSnack < Command
      def check_text
        check_user_spam if @txt.start_with?('/cancel')
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        check_empty_people
      end

      def check_empty_people
        @is_snack = Snack.new

        return if @is_snack.empty?(@bot, @id, @username, @symbol, @command)
        check_user_snack
      end

      def check_user_snack
        @db = Connection.new

        name = @txt.scan(/\B@\S+/)
        name.each do |cancel_name|
          user = @db.check_people(cancel_name)
          name = user.size.zero? ? nil : user.first['name']

          name.nil? ? empty_snack(cancel_name) : cancel_snack(cancel_name)
        end
      end

      def empty_snack(name)
        @bot.api.send_message(chat_id: @id, text: empty_people(name), parse_mode: 'HTML')
      end

      def cancel_snack(name)
        @db.cancel_people(name)
        @bot.api.send_message(chat_id: @id, text: msg_cancel_people(name))
      end
    end
  end
end
