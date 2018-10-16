module Bot
  class Command
    # untuk menambahkan staging ke daftar staging squad
    class AddStaging < Command
      def check_text
        check_format if @txt.start_with?("/add_staging")
      end

      def check_format
      	@is_squad = Squad.new

        return if @is_squad.empty?(@bot, @message.chat.id, @squad_name, @txt, @username)
        check_staging
      end

      def check_staging
      	@is_staging = Staging.new

        return if @is_staging.empty?(@bot, @message.chat.id, @staging, @username, @txt)
        check_staging_squad
      end

      def check_staging_squad
      	@db = Connection.new

        @squad = @txt.scan(/\s[a-zA-Z]+/)
        @staging = @txt.scan(/\d+/)
        @squad_input = @squad.to_s.gsub('", "', ", ").delete('["').delete('"]').strip

        @array_nil = []
        @array_dupe = []

        @staging.each do |stg|
          unless (@array_nil.include? stg) || (@array_dupe.include? stg)
            stg_squad = @db.check_staging(stg)
            @squad_name = stg_squad.size.zero? ? nil : stg_squad.first['book_squad']
            @squad_name.nil? ? @array_nil.push(stg) : @array_dupe.push(stg)
          end
        end
        
        check_stg_exist unless @array_nil.empty?
        duplicate_staging unless @array_dupe.empty?
      end
      
      def check_stg_exist
      	@array_add = []
        @array_update = []

      	@array_nil.each do |stg|
          check_exist = @db.check_stg_exist(stg)
          stg_exist = check_exist.size.zero? ? nil : check_exist.first['book_squad']
          stg_exist.nil? ? @array_add.push(stg) : @array_update.push(stg)
        end
        
        add_staging unless @array_add.empty?
        update_staging unless @array_update.empty? 
      end

      def add_staging
      	@array_add.each do |stg|
      	  @db.add_staging_squad(stg, @squad_input)
      	end
      	
      	@list = @array_add.to_s.gsub('", "', ", ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @message.chat.id, text: msg_add_stg_squad(@list, @squad_input, @username), parse_mode: 'HTML')
      end
      
      def update_staging
      	@array_update.each do |stg|
      	  @db.update_staging_squad(stg, @squad_input)
      	end
      	
      	@list = @array_update.to_s.gsub('", "', ", ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @message.chat.id, text: msg_update_stg_squad(@list, @squad_input, @username), parse_mode: 'HTML')
      end

      def duplicate_staging
      	@list = @array_dupe.to_s.gsub('", "', ", ").delete('["').delete('"]')
        @bot.api.send_message(chat_id: @message.chat.id, text: msg_dupe_stg_squad(@list, @squad_name), parse_mode: 'HTML')
      end
    end
  end
end
