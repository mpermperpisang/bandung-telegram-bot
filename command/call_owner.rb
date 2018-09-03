module Bot
    class Command
      # untuk menghapus, menambah atau mengedit anggota ke daftar hi5
      class CallOwner < Command
        def check_text
          check_user_spam if @txt.start_with?('/plat')
        end

        def check_user_spam
          @is_user = User.new

          @is_user.spammer?(@bot, @id, @username, @message, @command)
          return if @is_user.spam == true
          check_empty_vehicle
        end

        def check_empty_vehicle
          @is_vehicle = Vehicle.new

          return if @is_vehicle.empty?(@bot, @id, @username, @vehicle_number)
          check_user_vehicle
        end

        def check_user_vehicle
          @db = Connection.new

          @number = @txt.scan(/[a-zA-Z]{1,}\s[0-9]*\s[a-zA-Z]+/)

          @array_nil = []
          @array_exist = []

          @number.each do |vehicle|
            unless (@array_exist.include? vehicle) || (@array_nil.include? vehicle)
              check_user = @db.check_vehicle(vehicle)
              @name = check_user.size.zero? ? nil : check_user.first['ve_name']
              @name.nil? ? @array_nil.push(vehicle) : @array_exist.push(@name)
            end
          end
          announce_vehicle unless @array_exist.empty?
          empty_vehicle unless @array_nil.empty?
        end

        def announce_vehicle
          @array_same = []
          @array_diff = []

          @array_exist.each do |check|
            @array_same.push(check) if check == "@#{@username}"
            @array_diff.push(check) unless check == "@#{@username}"
          end

          @list_same = @array_same.to_s.gsub('", "', ", ").delete('["').delete('"]')
          @list_diff = @array_diff.to_s.gsub('", "', ", ").delete('["').delete('"]')
          @bot.api.send_message(chat_id: @id, text: same_vehicle(@username), parse_mode: 'HTML') unless @list_same.empty?
          @bot.api.send_message(chat_id: @id, text: forbid_vehicle(@username, @list_diff), parse_mode: 'HTML') unless @list_diff.empty?
        end

        def empty_vehicle
          @list = @array_nil.to_s.gsub('", "', ", ").delete('["').delete('"]')
          @bot.api.send_message(chat_id: @id, text: empty_owner(@username, @list), parse_mode: 'HTML')
        end
      end
    end
  end
