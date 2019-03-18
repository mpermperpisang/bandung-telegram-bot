module Bot
  class Command
    # untuk menambahkan orang ke jadwal snack
    class AddSnack < Command
      def check_text
        check_user_spam if @txt.start_with?("/add@#{ENV['BOT_SNACK']}")
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
        @array_dupe = []

        @dday.each do |day_name|
          @day = day_name[/\s[a-zA-Z0-9]{0}[a-zA-Z][^\s]+/]
          @add_name = day_name[/\B@\S+/]

          unless (@array_nil.include? @add_name) || (@array_dupe.include? @add_name)
            check_user = @db.check_people(@add_name)
            @snack_name = check_user.size.zero? ? nil : check_user.first['name']
            @day_nil.push(@day) if @snack_name.nil?
            @snack_name.nil? ? @array_nil.push(@add_name) : @array_dupe.push(@add_name)
          end
        end
        add_snack unless @array_nil.empty?
        duplicate_snack unless @array_dupe.empty?
      end

      def add_snack
        @dday = Day.new

        @dday_nil = []
        @arr_list = []
        i = 0

        @array_nil.each do |add_name|
          @dday.read_day(@day_nil[i])
          @db.add_people(@day_nil[i], add_name)
          @dday_nil.push(@dday.day_name)

          @arr_list.push("#{@array_nil[i]} bawa snack di hari <b>#{@dday_nil[i]}</b>")
          i += 1
        end

        @list = @arr_list.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @id, text: msg_add_people(@username, @list), parse_mode: 'HTML')
      end

      def duplicate_snack
        @list = @array_dupe.to_s.delete('["').delete('"]').gsub('", "', ', ')
        @bot.api.send_message(chat_id: @id, text: msg_duplicate_add_people(@username, @list), parse_mode: 'HTML')
      end
    end
  end
end
