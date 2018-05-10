module Bot
  class Command
    # untuk menghapus, menambah atau mengedit anggota ke daftar hi5
    class AddHi5 < Command
      def check_text
        @squad = @space.nil? ? '' : @space.strip
        check_squad if @txt == "/hi5 #{@squad} #{@symbol}"
      end

      def check_squad
        @msg.bot_squad
        check_member if @msg.squad.include?(@space.strip)
      end

      def check_member
        hi5_squad unless @symbol.nil?
      end

      def hi5_squad
        @db = Connection.new

        check_hi5_name = @db.check_hi5(@space.strip, @symbol)
        list_hi5_name = check_hi5_name.size.zero? ? nil : check_hi5_name.first['hi_name']

        name = @txt.scan(/\B@\S+/)
        name.each do |hi5_name|
          list_hi5_name.nil? ? add_edit(hi5_name) : delete_hi5(hi5_name)
        end
      end

      def add_edit(name)
        @name = name

        check_duplicate = @db.check_hi5_bandung(@name)
        list_name = check_duplicate.size.zero? ? nil : check_duplicate.first['hi_name']

        list_name.nil? ? add_hi5 : edit_hi5
      end

      def add_hi5
        @db.add_hi5(@space, @name)
        @bot.api.send_message(chat_id: @fromid, text: msg_add_hi5(@space, @name), parse_mode: 'HTML')
      end

      def edit_hi5
        @db.edit_hi5(@space, @name)
        @bot.api.send_message(chat_id: @fromid, text: msg_edit_hi5(@space, @name), parse_mode: 'HTML')
      end

      def delete_hi5(name)
        @db.delete_hi5(@space, name)
        @bot.api.send_message(chat_id: @fromid, text: msg_delete_hi5(@space, name), parse_mode: 'HTML')
      end
    end
  end
end
