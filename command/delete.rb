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

        @array = []
        @array_nil = []
        @array_status = []

        @name = @txt.scan(/\B@\S+/)
        @name.each do |delete_name|
          unless (@array.include? delete_name) || (@array_nil.include? delete_name)
            user = @db.check_people(delete_name)
            @user = user.size.zero? ? nil : user.first['name']
            @array.push(delete_name) unless @user.nil?
            @array_nil.push(delete_name) if @user.nil?
            @array_status.push(user.first['status']) unless @user.nil?
          end
        end

        empty_snack unless @array_nil.empty?
        delete_snack unless @array.empty?
      end

      def delete_snack
        @array.each do |name|
          @db.delete_people(name)
        end

        @list = @array.to_s.delete('["').delete('"]').gsub('", "', ', ')
        @bot.api.send_message(chat_id: @id, text: msg_delete_people(@list), parse_mode: 'HTML')
      end

      def empty_snack
        @list = @array_nil.to_s.delete('["').delete('"]').gsub('", "', ', ')
        @bot.api.send_message(chat_id: @id, text: empty_people(@list), parse_mode: 'HTML')
      end
    end
  end
end
