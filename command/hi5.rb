module Bot
  class Command
    # menampilkan daftar anggota hi5 squad Bandung
    class Hi5 < Command
      def check_text
        @squad = @squad_name.nil? ? nil : @squad_name.strip
        check_user_spam if [
          '/hi5', "/hi5@#{ENV['BOT_REMINDER']}", "/hi5 #{@squad}", "/hi5@#{ENV['BOT_REMINDER']} #{@squad}"
        ].include?(@txt)
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        check_squad
      end

      def check_squad
        @msg = MessageText.new
        @msg.bot_squad

        @squad = @squad_name.nil? ? nil : @squad_name.strip

        if @squad.nil?
          show_keyboard
        elsif @msg.squad.include?(@squad)
          hi5_member(@squad)
        else
          invalid_squad
        end
      end

      def show_keyboard
        key_squad
        inline_keyboard
        @bot.api.send_message(chat_id: @fromid, text: choosing_squad(@username), reply_markup: @markup)
        @bot.api.send_message(chat_id: @fromid, text: msg_invalid_hi5, parse_mode: 'HTML')
      rescue StandardError
        @bot.api.send_message(chat_id: @id, text: private_message(@username))
      end

      def hi5_member(data)
        @db = Connection.new

        @result = @db.bandung_hi5_squad(data)
        @count = @result.count
        list_hi5_name

        @team = @squad.nil? ? @txt : @squad
        @list_hi5_member = @array.to_s.gsub('", "', ' ').delete('["').delete('"]')
        @hi5_name = @result.size.zero? ? empty_member(@team, @username) : @list_hi5_member

        if @hi5_name =~ /kosong/
          @bot.api.send_message(chat_id: @fromid, text: @hi5_name.to_s, parse_mode: 'HTML')
        else
          @choose_squad = @squad.nil? ? @txt : @squad
          hi5_squad unless @choose_squad.nil?
        end
      end

      def list_hi5_name
        @array = []
        @result.each { |row| @array.push(row['hi_name']) }
      end

      def hi5_squad
        if @choose_squad.casecmp('BANDUNG').zero?
          @bot.api.send_message(chat_id: @id, text: list_hi5(@choose_squad, @count) + by_user(@username), parse_mode: 'HTML')
          @bot.api.send_message(chat_id: @id, text: @hi5_name.to_s + "\n\n" + update_bukabandung, parse_mode: 'HTML')
        else
          @bot.api.send_message(chat_id: @fromid, text: list_hi5(@choose_squad, @count), parse_mode: 'HTML')
          @bot.api.send_message(chat_id: @fromid, text: "<code>#{@hi5_name}</code>", parse_mode: 'HTML')
        end
      end

      def member_email
        @db = Connection.new

        @hi5_email = @db.bandung_email
        @array = []
        @hi5_email.each { |row| @array.push(row['hi_email']) }
        @list_email = @array.to_s.gsub('", "', "\n").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @message.from.id, text: 'List email squad <b>BANDUNG</b>', parse_mode: 'HTML')
        @bot.api.send_message(chat_id: @message.from.id, text: "<code>#{@list_email}</code>", parse_mode: 'HTML')
      end

      def invalid_squad
        @bot.api.send_message(chat_id: @id, text: msg_invalid_squad(@squad_name, @username), parse_mode: 'HTML')
      end
    end
  end
end
