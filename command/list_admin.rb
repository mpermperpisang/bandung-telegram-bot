module Bot
  class Command
    # untuk menambahkan orang ke jadwal snack
    class ListAdmin < Command
      def check_text
        check_user_spam if @txt.start_with?("/list_admin")
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        list_admin
      end

      def list_admin
        @db = Connection.new

        @array = []

        name = @db.list_admin
        name.each do |admin|
          @array.push(admin['adm_username'])
        end

        @list = @array.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @chatid, text: msg_list_admin(@username, @list), parse_mode: 'HTML')
      end
    end
  end
end
