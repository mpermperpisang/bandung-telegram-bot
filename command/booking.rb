module Bot
  class Command
    # untuk booking suatu staging
    class Booking < Command
      def check_text
        check_stg_empty if @txt.start_with?('/booking')
      end

      def check_stg_empty
        @is_staging = Staging.new
        @db = Connection.new

        next_stg_not_empty unless @is_staging.empty?(@bot, @chatid, @staging, @username, @txt)
      end

      def next_stg_not_empty
        booking_stg unless @is_staging.bbm?(@bot, @chatid, @staging, @username)
      end

      def booking_stg
        check_booked = @db.status_booking(@staging)
        staging = check_booked.first['book_status'] || check_booked.first['book_name']
        book_status = staging.empty? ? nil : check_booked.first['book_status']
        book_name = staging.empty? ? nil : check_booked.first['book_name']

        return if @is_staging.booked?(@bot, @id, @username, book_status, book_name, @staging)
        book_staging
      end

      def book_staging
        @db.book_staging(@username, @fromid, @staging)
        @bot.api.send_message(chat_id: @id, text: msg_book_staging(@username, @staging), parse_mode: 'HTML')
      end
    end
  end
end
