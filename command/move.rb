module Bot
  class Command
    # untuk mengubah jadwal snack sementara
    class Move < Command
      def check_text
        check_user_spam if @txt.start_with?('/move')
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
        check_admin
      end

      def check_admin
        return if @is_user.admin?(@bot, @id, @username)
        check_empty_day
      end

      def check_empty_day
        @msg = MessageText.new
        @send = SendMessage.new

        @send.err_day_snack(@id, @command)
        @msg.weekdays

        day = @space.nil? ? nil : @space.strip
        if @symbol.nil? || @msg.days.none? { |n| n == day }
          @bot.api.send_message(@send.message)
        else
          check_user_snack
        end
      end

      def check_user_snack
        @db = Connection.new

        @dday = @txt.scan(/\s[a-zA-Z0-9]{0}[a-zA-Z0][^\s]+\s@[a-zA-Z0-9_^]+/)

        @array_nil = []
        @day_nil = []
        @array_exist = []

        @dday.each do |day_name|
          @day = day_name[/\s[a-zA-Z0-9]{0}[a-zA-Z][^\s]+/]
          @edit_name = day_name[/\B@\S+/]

          unless (@array_exist.include? @edit_name) || (@array_nil.include? @edit_name)
            check_user = @db.check_people(@edit_name)
            @snack_name = check_user.size.zero? ? nil : check_user.first['name']
            @day_nil.push(@day) unless @snack_name.nil?
            @snack_name.nil? ? @array_nil.push(@edit_name) : @array_exist.push(@edit_name)
          end
        end
        edit_snack unless @array_exist.empty?
        empty_snack unless @array_nil.empty?
      end

      def edit_snack
        @dday = Day.new

        @dday_nil = []
        @arr_list = []
        i = 0

        @array_exist.each do |edit_name|
          @dday.read_day(@day_nil[i])
          @db.edit_people(@day_nil[i], edit_name)
          @dday_nil.push(@dday.day_name)

          @arr_list.push("#{@array_exist[i]} jadwalmu sementara dipindah ke hari <b>#{@dday_nil[i]}</b>")
          i += 1
        end

        @list = @arr_list.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @id, text: msg_edit_people(@username, @list), parse_mode: 'HTML')
      end

      def empty_snack
        @list = @array_nil.to_s.delete('["').delete('"]').gsub('", "', ', ')
        @bot.api.send_message(chat_id: @id, text: empty_people(@list), parse_mode: 'HTML')
      end
    end
  end
end
