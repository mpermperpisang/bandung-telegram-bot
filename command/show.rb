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
        list_poin = @db.list_poin
        list = File.read('./require_ruby.rb')
        list1 = list.gsub('{"member_market"=>"', '')
        list2 = list1.gsub('", "poin_market"=>"', ' ngasih poin ')
        list3 = list2.gsub('"}', '')

        poin_number = list_poin.empty? ? empty_poin : list_poin_market(list3)
        @bot.api.send_message(chat_id: @chatid, text: poin_number)
        @bot.api.send_message(chat_id: @chatid, text: next_poin)
        @db.message_from_id

        list = File.read('./require_ruby.rb')
        list1 = list.gsub('{"from_id_market"=>"', '')
        @line = list1.gsub('"}', '')
        send_poin
      end

      def send_poin
        if @line.nil? || @line == '' || @line == "\n"
          @bot.api.send_message(chat_id: @fromid, text: msg_new_poin)
        else
          @line.each_line do |id_private|
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
