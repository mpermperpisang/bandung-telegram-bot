module Bot
  class Command
    # untuk menambahkan anggota ke marketplace
    class AddMarketplace < Command
      def check_text
        check_empty_member if @txt.start_with?("/add_marketplace")
      end
      
      def check_empty_member
      	@send = SendMessage.new
      	
      	if @symbol.nil?
      	  @send.empty_member(@message.chat.title, @command)
      	  @bot.api.send_message(@send.message)
      	else	
          check_member_marketplace
        end
      end

      def check_member_marketplace
      	@db = Connection.new

        @username = @txt.scan(/\B@\S+/)

        @array_nil = []
        @array_dupe = []

        @username.each do |marketplace|
          unless (@array_nil.include? marketplace) || (@array_dupe.include? marketplace)
            check_user = @db.check_marketplace(@message.chat.title, marketplace)
            @name = check_user.size.zero? ? nil : check_user.first['member_market']
            @name.nil? ? @array_nil.push(marketplace) : @array_dupe.push(marketplace)
          end
        end

        add_marketplace unless @array_nil.empty?
        duplicate_marketplace unless @array_dupe.empty?
      end

      def add_marketplace
      	@array_nil.each do |name|
          @db.add_member_market(@message.chat.title, name)
        end

        @list = @array_nil.to_s.gsub('", "', ", ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @chatid, text: msg_add_marketplace(@list, @message.chat.title), parse_mode: 'HTML')
      end

      def duplicate_marketplace
      	@list = @array_dupe.to_s.gsub('", "', ", ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @chatid, text: msg_dupe_marketplace(@list, @message.chat.title), parse_mode: 'HTML')
      end
    end
  end
end
