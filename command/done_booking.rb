module Bot
  class Command
    # jika sudah selesai memakai staging
    class DoneBooking < Command
      def check_text
        check_stg_empty if @txt.start_with?("/done_#{@staging}", '/done')
      end

      def check_stg_empty
        @is_staging = Staging.new

        done_book_stg unless @is_staging.empty?(@bot, @chatid, @staging, @username, @base_command)
      end

      def done_book_stg
        @db = Connection.new
        @send = SendMessage.new

        staging = [*1..132].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@id, @username, @staging)
        staging == 'new' ? @bot.api.send_message(@send.message) : check_user_booked
      end

      def check_user_booked
        book_staging = @db.done_booking(@staging)
        book_name = book_staging.size.zero? ? nil : book_staging.first['book_name']
        @db.done_staging(@staging)

        @bot.api.send_message(chat_id: @id, text: msg_done_staging(book_name, @staging), parse_mode: 'HTML')
      end
    end
  end
end
