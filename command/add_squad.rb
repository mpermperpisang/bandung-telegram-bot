module Bot
  class Command
    # untuk menambahkan orang ke jadwal snack
    class AddSquad < Command
      def check_text
        check_user_spam if @txt.start_with?("/squad")
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        check_admin
      end

      def check_admin
        return if @is_user.admin?(@bot, @id, @username)
        check_squad
      end

      def check_squad
        @db = Connection.new

        @squad = @txt.scan(/\s[a-zA-Z]{2,}/)

        @array_nil = []
        @array_dupe = []

        @squad.each do |squad|
          unless (@array_nil.include? squad) || (@array_dupe.include? squad)
            check_user = @db.check_squad(squad)
            name = check_user.size.zero? ? nil : check_user.first['squad_name']
            name.nil? ? @array_nil.push(squad) : @array_dupe.push(squad)
          end
        end

        add_squad unless @array_nil.empty?
        duplicate_squad unless @array_dupe.empty?
      end

      def add_squad
        @array_nil.each do |squad|
          @db.add_bandung_squad(squad)
        end

        @list = @array_nil.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @chatid, text: msg_add_squad(@list), parse_mode: 'HTML')
      end

      def duplicate_squad
        @list = @array_dupe.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @fromid, text: msg_dupe_squad(@list), parse_mode: 'HTML')
      end
    end
  end
end
