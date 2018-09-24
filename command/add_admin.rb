module Bot
  class Command
    # untuk menambahkan orang ke jadwal snack
    class AddAdmin < Command
      def check_text
        check_user_spam if @txt.start_with?("/admin")
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        check_admin
      end

      def check_admin
        return if @is_user.admin?(@bot, @id, @username)
        check_admin_snack
      end

      def check_admin_snack
        @db = Connection.new

        @username = @txt.scan(/\B@\S+/)

        @array_nil = []
        @array_dupe = []

        @username.each do |admin|
          unless (@array_nil.include? admin) || (@array_dupe.include? admin)
            check_user = @db.check_admin(admin)
            @name = check_user.size.zero? ? nil : check_user.first['adm_username']
            @name.nil? ? @array_nil.push(admin) : @array_dupe.push(admin)
          end
        end

        add_admin unless @array_nil.empty?
        duplicate_admin unless @array_dupe.empty?
      end

      def add_admin
        @array_nil.each do |name|
          @db.add_admin_snack(name)
        end

        @list = @array_nil.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @chatid, text: msg_add_admin(@list), parse_mode: 'HTML')
      end

      def duplicate_admin
        @list = @array_dupe.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @fromid, text: msg_dupe_admin(@list), parse_mode: 'HTML')
      end
    end
  end
end
