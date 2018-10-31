module Bot
  class Command
    # untuk menambahkan orang ke jadwal snack
    class Market < Command
      def check_text
        choose_market_squad if @txt.downcase.start_with?("market")
      end

      def choose_market_squad
      	@db = Connection.new
      	
      	@number = @txt.scan(/\d+/)
      	
      	@array = []
      	
        @count_member = @db.check_count_member("@#{@username}")
        i = 1
        if @count_member.count >= 2
          @count_member.each do |row|
            if i.to_i == @number.join.to_i
              @id_squad = row['group_market']
            end
            i += 1
          end
        end
        
        @db.on_squad("@#{@username}", @id_squad)
      end
    end
  end
end
