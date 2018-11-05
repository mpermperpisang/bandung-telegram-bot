module Bot
  class Command
    # untuk menghapus anggota dari marketplace grup
    class DeleteMarketplace < Command
      def check_text
        check_empty_member if @txt.start_with?("/delete_marketplace")
      end
      
      def check_empty_member
      	@send = SendMessage.new
      	
      	if @symbol.nil?
      	  @send.empty_member(@chatid, @txt)
      	  @bot.api.send_message(@send.message)
      	else	
          check_member_marketplace
        end
      end

      def check_member_marketplace
      	@db = Connection.new

        @username = @txt.scan(/\B@\S+/)

        @array_exist = []
        @array_empty = []

        @username.each do |marketplace|
          unless (@array_exist.include? marketplace) || (@array_empty.include? marketplace)
            check_user = @db.check_marketplace(@message.chat.title, marketplace)
            @name = check_user.size.zero? ? nil : check_user.first['member_market']
            @name.nil? ? @array_exist.push(marketplace) : @array_empty.push(marketplace)
          end
        end

        delete_marketplace unless @array_empty.empty?
        empty_marketplace unless @array_exist.empty?
      end

      def delete_marketplace
      	@array_empty.each do |name|
          @db.delete_member_market(@message.chat.title, name)
        end

        @list = @array_empty.to_s.gsub('", "', ", ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @chatid, text: msg_delete_marketplace(@list, @message.chat.title), parse_mode: 'HTML')
      end

      def empty_marketplace
      	@list = @array_exist.to_s.gsub('", "', ", ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @chatid, text: msg_empty_marketplace(@list, @message.chat.title), parse_mode: 'HTML')
      end
    end
  end
end
