module Bot
  class Command
    # mengembalikan jadwal snack sesuai dengan data di confluence
    class Normal < Command
      def check_text
        check_user_spam if @txt.start_with?('/normal')
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        normal_snack
      end

      def normal_snack
        @db = Connection.new

        @db.normal_snack
        @bot.api.send_message(chat_id: @id, text: msg_normal_snack, parse_mode: 'HTML')
      end
    end
  end
end
