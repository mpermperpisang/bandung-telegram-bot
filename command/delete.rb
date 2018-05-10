module Bot
  class Command
    # untuk menghapus username dari daftar snack
    class Delete < Command
      def check_text
        check_user_spam if @txt.start_with?('/delete')
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

        name = @txt.scan(/\B@\S+/)
        name.each do |delete_name|
          user = @db.check_people(delete_name)
          name = user.size.zero? ? nil : user.first['name']

          name.nil? ? empty_snack(delete_name) : delete_snack(delete_name)
        end
      end

      def delete_snack(name)
        @db.delete_people(name)
        @bot.api.send_message(chat_id: @id, text: msg_delete_people(name))
      end

      def empty_snack(name)
        @bot.api.send_message(chat_id: @id, text: empty_people(name), parse_mode: 'HTML')
      end
    end
  end
end
