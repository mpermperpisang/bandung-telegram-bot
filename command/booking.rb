module Bot
  class Command
    # untuk booking suatu staging
    class Booking < Command
      def check_text
        check_stg_empty if @txt.start_with?('/booking')
      end

      def check_stg_empty
        @is_staging = Staging.new

        booking_stg unless @is_staging.empty?(@bot, @chatid, @staging, @username, @command)
      end

      def booking_stg
        @db = Connection.new
        @send = SendMessage.new

        max_stg = @db.check_max_stg
        stg_number = max_stg.first['book_staging'].to_s.gsub('book_','')

        staging = [*1..stg_number.to_i].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@chatid, @username, @staging)
        if staging == 'new'
          @bot.api.send_message(@send.message)
          @db.add_new_staging(@staging)
        end
        check_user_booked
      end

      def insert_staging
        @db.add_staging(@staging, @username, @fromid)
      end

      def check_user_booked
        check_booked = @db.check_booked(@staging)
        insert_staging if check_booked.size.zero?
        book_status = check_booked.size.zero? ? nil : check_booked.first['book_status']
        book_name = check_booked.size.zero? ? nil : check_booked.first['book_name']

        return if @is_staging.done?(@bot, @chatid, @username, book_status, book_name, @staging)
        book_staging
      end

      def book_staging
        @db.book_staging(@username, @fromid, @staging)
        @bot.api.send_message(chat_id: @chatid, text: msg_book_staging(@username, @staging), parse_mode: 'HTML')
      end
    end
  end
end
