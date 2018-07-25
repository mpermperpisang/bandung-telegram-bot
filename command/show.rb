module Bot
  class Command
    # untuk menampilkan poin ke grup
    class Show < Command
      def check_text
        show_poin if @txt.start_with?('/show')
      end

      def show_poin
        @is_user = User.new

        return if @is_user.pm?(@bot, @fromid, @username)
        displaying_poin
      end

      def displaying_poin
        @db = Connection.new

        @db.update_id_closed(@fromid)
        show_poin_market
        count_poin
        zero_poin

        @count = "  #{@c_half} #{@c_one} #{@c_two}
#{@c_three}  #{@c_five}  #{@c_eight}
#{@c_thirteen}  #{@c_twenty}  #{@c_fourty}
#{@c_hundred}  #{@c_coffee}  #{@c_unlimited}  "

        poin_number = @list_poin.size.zero? ? empty_poin : list_poin_market(@show_poin, @count.gsub(/\s\s+/, "\n"))

        @bot.api.send_message(chat_id: @chatid, text: poin_number)
        @bot.api.send_message(chat_id: @chatid, text: next_poin)
        @from_id = @db.message_from_id

        @array = []
        @from_id.each { |row| @array.push(row['from_id_market']) }
        @line = @array
        send_poin
      end

      def count_poin
        @half = @db.list_poin_half.count
        @one = @db.list_poin_one.count
        @two = @db.list_poin_two.count
        @three = @db.list_poin_three.count
        @five = @db.list_poin_five.count
        @eight = @db.list_poin_eight.count
        @thirteen = @db.list_poin_thirteen.count
        @twenty = @db.list_poin_twenty.count
        @fourty = @db.list_poin_fourty.count
        @hundred = @db.list_poin_hundred.count
        @coffee = @db.list_poin_coffee.count
        @unlimited = @db.list_poin_unlimited.count
      end

      def zero_poin
        @c_half = "1/2 = #{@half} orang" unless @half.zero?
        @c_one = "1 = #{@one} orang" unless @one.zero?
        @c_two = "2 = #{@two} orang" unless @two.zero?
        @c_three = "3 = #{@three} orang" unless @three.zero?
        @c_five = "5 = #{@five} orang" unless @five.zero?
        @c_eight = "8 = #{@eight} orang" unless @eight.zero?
        @c_thirteen = "13 = #{@thirteen} orang" unless @thirteen.zero?
        @c_twenty = "20 = #{@twenty} orang" unless @twenty.zero?
        @c_fourty = "40 = #{@fourty} orang" unless @fourty.zero?
        @c_hundred = "100 = #{@hundred} orang" unless @hundred.zero?
        @c_coffee = "Kopi = #{@coffee} orang" unless @coffee.zero?
        @c_unlimited = "Unlimited = #{@unlimited} orang" unless @unlimited.zero?
      end

      def show_poin_market
        @list_poin = @db.list_poin
        @array = []
        @list_poin.each do |row|
          @array.push(row['member_market'] + ' ngasih poin ' + row['poin_market'])
        end
        @show_poin = @array.to_s.gsub('", "', "\n").delete('["').delete('"]')
      end

      def send_poin
        if @line.nil? || @line == '' || @line == "\n" || @line.size.zero?
          @bot.api.send_message(chat_id: @fromid, text: msg_new_poin)
        else
          @line.each do |id_private|
            txt_private = case id_private
                          when "284392817\n", "366569214\n"
                            msg_new_poin
                          else
                            msg_new_poin_member
                          end
            @bot.api.send_message(chat_id: id_private, text: txt_private)
            @bot.api.send_message(chat_id: id_private, text: show_command)
          end
        end

        @db.update_market_open
      end
    end
  end
end
