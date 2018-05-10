module Bot
  class Command
    # menampilkan daftar anggota hi5 squad Bandung
    class Hi5 < Command
      def check_text
        @squad = @space.nil? ? nil : @space.strip
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

        @squad = @space.nil? ? nil : @space.strip

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
      rescue StandardError
        @bot.api.send_message(chat_id: @id, text: private_message(@username))
      end

      def hi5_member(data)
        @db = Connection.new

        @result = @db.bandung_hi5_squad(data)
        @count = @result.count
        list_hi5_name

        @team = @squad.nil? ? @txt : @squad
        @hi5_name = @result.size.zero? ? empty_member(@team, @username) : @list3

        if @hi5_name =~ /kosong/
          @bot.api.send_message(chat_id: @fromid, text: @hi5_name.to_s)
        else
          @choose_squad = @squad.nil? ? @txt : @squad
          hi5_squad unless @choose_squad.nil?
        end
      end

      def list_hi5_name
        list_name = File.read('./require_ruby.rb')
        list1 = list_name.gsub('{"hi_name"=>"', '')
        list2 = list1.gsub('"}', '')
        @list3 = list2.tr("\n", ' ')
      end

      def hi5_squad
        if @choose_squad.casecmp('BANDUNG').zero?
          @bot.api.send_message(chat_id: @id, text: list_hi5(@choose_squad, @count) + by_user(@username), parse_mode: 'HTML')
          @bot.api.send_message(chat_id: @id, text: @hi5_name.to_s)
        else
          @bot.api.send_message(chat_id: @fromid, text: list_hi5(@choose_squad, @count), parse_mode: 'HTML')
          @bot.api.send_message(chat_id: @fromid, text: "<code>#{@hi5_name}</code>", parse_mode: 'HTML')
        end
      end

      def member_email
        @db = Connection.new

        @db.bandung_email
        list_email = File.read('./require_ruby.rb')
        list1 = list_email.gsub('{"hi_email"=>"', '')
        list2 = list1.gsub('"}', '')

        @bot.api.send_message(chat_id: @message.from.id, text: 'List email squad <b>BANDUNG</b>', parse_mode: 'HTML')
        @bot.api.send_message(chat_id: @message.from.id, text: "<code>#{list2}</code>", parse_mode: 'HTML')
      end

      def invalid_squad
        @bot.api.send_message(chat_id: @id, text: msg_invalid_squad(@space, @username), parse_mode: 'HTML')
      end
    end
  end
end
