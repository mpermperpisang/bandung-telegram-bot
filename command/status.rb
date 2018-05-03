require './helper/bot_connect_db.rb'

module Bot
  class Command
    class Status < Command
      @@booking = BBMBooking.new

      def check_staging
        #INI try to refactor
        Bot::DBConnect.new.status_staging
        @@booking.gsub_staging_status
        @bot.api.send_message(chat_id: @id, text: @@booking.cek_status, parse_mode: 'HTML')
      end
    end
  end
end
