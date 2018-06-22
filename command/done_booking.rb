module Bot
  class Command
    # jika sudah selesai memakai staging
    class DoneBooking < Command
      def check_text
        check_stg_empty if @txt.start_with?("/done_#{@staging}", '/done')
      end

      def check_stg_empty
        @is_staging = Staging.new

        done_book_stg unless @is_staging.empty?(@bot, @chatid, @staging, @username, @command)
      end

      def done_book_stg
        @db = Connection.new
        @send = SendMessage.new

        staging = [*1..134].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@chatid, @username, @staging)
        staging == 'new' ? @bot.api.send_message(@send.message) : check_user_booked
      end

      def check_user_booked
        book_staging = @db.done_booking(@staging)
        @book_name = book_staging.size.zero? ? nil : book_staging.first['book_name']
        @book_status = book_staging.size.zero? ? nil : book_staging.first['book_status']
        @db.done_staging(@staging)

        @book_name.nil? ? not_exist_staging : done_staging
      end

      def not_exist_staging
        @bot.api.send_message(chat_id: @chatid, text: stg_not_exist(@staging), parse_mode: 'HTML')
      end

      def done_staging
        @send = SendMessage.new

        @send.done_status(@chatid, @book_name, @staging)
        @bot.api.send_message(@send.message) if @book_status.eql?('booked')
      end
    end
  end
end
