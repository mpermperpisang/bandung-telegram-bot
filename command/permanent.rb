module Bot
  class Command
    # mengubah jadwal snack secara permanent, dan harus mengubah confluence juga
    class Permanent < Command
      def check_text
        check_user_spam if @txt.start_with?('/permanent')
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
        @array_exist = []

        @dday.each do |day_name|
          @day = day_name[/\s[a-zA-Z0-9]{0}[a-zA-Z][^\s]+/]
          @move_name = day_name[/\B@\S+/]

          unless (@array_exist.include? @move_name) || (@array_nil.include? @move_name)
            check_user = @db.check_people(@move_name)
            @snack_name = check_user.size.zero? ? nil : check_user.first['name']
            @day_nil.push(@day) unless @snack_name.nil?
            @snack_name.nil? ? @array_nil.push(@move_name) : @array_exist.push(@move_name)
          end
        end
        change_snack unless @array_exist.empty?
        empty_snack unless @array_nil.empty?
      end

      def change_snack
        @dday = Day.new

        @dday_nil = []
        @arr_list = []
        i = 0

        @array_exist.each do |move_name|
          @dday.read_day(@day_nil[i])
          @db.change_people(@day_nil[i], move_name)
          @dday_nil.push(@dday.day_name)

          @arr_list.push("#{@array_exist[i]} hari <b>#{@dday_nil[i]}</b> adalah jadwalmu yang baru")
          i += 1
        end

        @list = @arr_list.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @id, text: msg_change_people(@username, @list), parse_mode: 'HTML')
      end

      def empty_snack
        @list = @array_nil.to_s.delete('["').delete('"]').gsub('", "', ', ')
        @bot.api.send_message(chat_id: @id, text: empty_people(@list), parse_mode: 'HTML')
      end
    end
  end
end
