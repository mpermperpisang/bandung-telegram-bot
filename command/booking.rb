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

        staging = [*1..132].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@id, @username, @staging)
        staging == 'new' ? @bot.api.send_message(@send.message) : check_user_booked
      end

      def insert_staging
        @db.add_staging(@staging, @username, @fromid)
      end

      def check_user_booked
        check_booked = @db.check_booked(@staging)
        insert_staging if check_booked.size.zero?
        book_status = check_booked.size.zero? ? nil : check_booked.first['book_status']
        book_name = check_booked.size.zero? ? nil : check_booked.first['book_name']

        return if @is_staging.done?(@bot, @id, @username, book_status, book_name, @staging)
        book_staging
      end

      def book_staging
        @db.book_staging(@username, @fromid, @staging)
        @bot.api.send_message(chat_id: @id, text: msg_book_staging(@username, @staging), parse_mode: 'HTML')
      end
    end
  end
end
