require './is_true/staging.rb'

module Bot
  class Command
    class DoneBooking < Command
      @@staging = Staging.new
      @@booking = BBMBooking.new

      def done_booking
        unless @@staging.is_empty?(@bot, @id, @message, @base_command, @staging)
          if @@staging.is_bbm?(@staging)
            self.done(@staging)
          else
            @bot.api.send_message(chat_id: @id, text: errorStaging(@message.from.username))
          end
        end
      end

      def done(staging)
        book_staging = Bot::DBConnect.new.done_booking(staging)
        book_name = book_staging.empty? ? nil : book_staging[0]['book_name']
        Bot::DBConnect.new.done_staging(staging)

        @bot.api.send_message(chat_id: @id, text: msg_done_staging(book_name, staging), parse_mode: 'HTML')
      end
    end
  end
end
