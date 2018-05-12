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
        poin_number = @list_poin.empty? ? empty_poin : list_poin_market(@show_poin)
        @bot.api.send_message(chat_id: @chatid, text: poin_number)
        @bot.api.send_message(chat_id: @chatid, text: next_poin)
        @from_id = @db.message_from_id

        @array = []
        @from_id.each do |row|
          @array.push(row['from_id_market'])
        end
        @line = @array
        send_poin
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
