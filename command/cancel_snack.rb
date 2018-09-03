module Bot
  class Command
    # membatalkan seseorang membawa snack jika berbohong
    class CancelSnack < Command
      def check_text
        check_user_spam if @txt.start_with?('/cancel')
      end

      def check_user_spam
        @is_user = User.new

        @is_user.spammer?(@bot, @id, @username, @message, @command)
        return if @is_user.spam == true
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
        @name.each do |cancel_name|
          unless (@array.include? cancel_name) || (@array_nil.include? cancel_name)
            user = @db.check_people(cancel_name)
            @user = user.size.zero? ? nil : user.first['name']
            @array.push(cancel_name) unless @user.nil?
            @array_nil.push(cancel_name) if @user.nil?
            @array_status.push(user.first['status']) unless @user.nil?
          end
        end

        empty_snack unless @array_nil.empty?
        cancel_snack unless @array.empty?
      end

      def empty_snack
        @list = @array_nil.to_s.delete('["').delete('"]').gsub('", "', ', ')
        @bot.api.send_message(chat_id: @id, text: empty_people(@list), parse_mode: 'HTML')
      end

      def cancel_snack
        @array.each do |name|
          @db.cancel_people(name)
        end

        if @array_status.include?('libur') || @array_status.include?('sudah')
          @list = @array.to_s.delete('["').delete('"]').gsub('", "', ', ')
          @bot.api.send_message(chat_id: @id, text: msg_cancel_people(@list))
        end
      end
    end
  end
end
