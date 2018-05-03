require './is_true/staging.rb'
require './helper/bbm_booking.rb'

module Bot
  class Command
    class Booking < Command
      @@staging = Staging.new
      @@booking = BBMBooking.new

      def booking_staging
        unless @@staging.is_empty?(@bot, @id, @message, @base_command, @staging)
          if @@staging.is_bbm?(@staging)
            self.booking(@staging)
          else
            @bot.api.send_message(chat_id: @id, text: errorStaging(@message.from.username))
          end
        end
      end

      def booking(staging)
        book_staging = Bot::DBConnect.new.status_booking(staging)
        book_status = book_staging.empty? ? nil : book_staging[0]['book_status']
        book_name = book_staging.empty? ? nil : book_staging[0]['book_name']

        case book_status
        when "done"
          Bot::DBConnect.new.book_staging(@message.from.username, @message.from.id, staging)
          @bot.api.send_message(chat_id: @id, text: msg_book_staging(@message.from.username, staging), parse_mode: 'HTML')
        else
          @bot.api.send_message(chat_id: @id, text: msg_using_staging(book_name, staging, @message.from.username), parse_mode: 'HTML')
        end
      end
    end
  end
end
