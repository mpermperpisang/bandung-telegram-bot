module Bot
  class Command
    # untuk menampilkan poin ke grup
    class Show < Command
      def check_text
        show_poin if @txt.start_with?('/show')
        File.open("./file/require_ruby#{@message.chat.id}.rb", 'w+') do |f|
          f.puts('======================================')
        end
      end

      def show_poin
        @is_user = User.new

        return if @is_user.pm?(@bot, @fromid, @username)
        displaying_poin
      end

      def displaying_poin
        @db = Connection.new

        @db.update_id_closed(@fromid, @message.chat.title)
        show_poin_market
        count_poin
        zero_poin

        @count = "  #{@c_half}  #{@c_one}  #{@c_two}
#{@c_three}  #{@c_five}  #{@c_eight}
#{@c_thirteen}  #{@c_twenty}  #{@c_fourty}
#{@c_hundred}  #{@c_coffee}  #{@c_unlimited}  "

        poin_number = @list_poin.size.zero? ? empty_poin : list_poin_market(@show_poin, @count.gsub(/\s\s+/, "\n"))

        @bot.api.send_message(chat_id: @chatid, text: poin_number)
        @bot.api.send_message(chat_id: @chatid, text: next_poin)
        @from_id = @db.message_from_id(@message.chat.title)

        @array = []
        @from_id.each { |row| @array.push(row['from_id_market']) }
        @line = @array
        send_poin
      end

      def count_poin
        @half = @db.list_poin_half(@message.chat.title).count
        @one = @db.list_poin_one(@message.chat.title).count
        @two = @db.list_poin_two(@message.chat.title).count
        @three = @db.list_poin_three(@message.chat.title).count
        @five = @db.list_poin_five(@message.chat.title).count
        @eight = @db.list_poin_eight(@message.chat.title).count
        @thirteen = @db.list_poin_thirteen(@message.chat.title).count
        @twenty = @db.list_poin_twenty(@message.chat.title).count
        @fourty = @db.list_poin_fourty(@message.chat.title).count
        @hundred = @db.list_poin_hundred(@message.chat.title).count
        @coffee = @db.list_poin_coffee(@message.chat.title).count
        @unlimited = @db.list_poin_unlimited(@message.chat.title).count
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
        @list_poin = @db.list_poin(@message.chat.title)
        @array = []
        @list_poin.each do |row|
          @array.push(row['member_market'] + ' ngasih poin ' + row['poin_market'])
        end
        @show_poin = @array.to_s.gsub('", "', "\n").delete('["').delete('"]')
      end

      def send_poin
      	@member = []
      	
        if @line.nil? || @line == '' || @line == "\n" || @line.size.zero?
          @db.update_choose_market(@message.chat.title)
          @list_member = @db.check_id_member
          
          @list_member.each do |row|
          	@count_member = @db.check_count_member(row['member_market'])
          	
          	if @count_member.count >= 2
          	  unless (@member.include? row['member_market'])
          	  	@member.push(row['member_market'])
          	  end
            end
          end
          
          @member.each do |member|
          	@array = []
          	@chat = []
          	@group = []
          	
          	i = 1
          	
            @check_member = @db.check_count_member(member)
            @check_member.each do |list|
              @array.push("#{i}. #{list['group_market']}")
              @group.push("#{list['group_market']}")
              @chat.push("#{list['from_id_market']}")
            
              @list = @array.to_s.gsub('", "', "\n").delete('["').delete('"]')
              @idchat = @chat.to_s.gsub('", "', "\n").delete('["').delete('"]')
              i += 1
            end
            
            if @group.include?(@message.chat.title)
              @bot.api.send_message(chat_id: @idchat, text: msg_new_poin(@message.chat.title), parse_mode: 'HTML')
              @bot.api.send_message(chat_id: @idchat, text: choose_market(@list), parse_mode: 'HTML')
            end
          end
        else
          @line.each do |id_private|
            txt_private = case id_private
                          when "284392817\n", "366569214\n"
                            msg_new_poin(@message.chat.title)
                          else
                            msg_new_poin_member(@message.chat.title)
                          end
            @bot.api.send_message(chat_id: id_private, text: txt_private, parse_mode: 'HTML')
            @bot.api.send_message(chat_id: id_private, text: show_command)
          end
        end

        @db.update_market_open(@message.chat.title)
      end
    end
  end
end
