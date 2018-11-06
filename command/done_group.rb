module Bot
  class Command
    # jika sudah bawa snack tapi kirim chat di group
    class DoneSnackGroup < Command
      def check_text
        check_user_spam if @txt.start_with?('/done')
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        done_group
      end

      def done_group
        @bot.api.send_message(chat_id: @id, text: "Sekarang <code>/done</code> hanya bisa melalui private message, Kak @#{@username}\nYuk japri aku cie cie cie", parse_mode: 'HTML')
      end
    end
  end
end
