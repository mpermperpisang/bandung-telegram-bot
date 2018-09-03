module Bot
    class Command
      # untuk menghapus, menambah atau mengedit anggota ke daftar hi5
      class AddVehicle < Command
        def check_text
          check_empty_vehicle if @txt.start_with?('/plat', "/plat #{@ve_owner} #{@ve_type} #{@ve_plat}")
        end

        def check_empty_vehicle
          @is_vehicle = Vehicle.new

          return if @is_vehicle.add_empty?(@bot, @id, @username, @vehicle_number)
          check_user_vehicle
        end

        def check_user_vehicle
          @db = Connection.new

          @number = @txt.scan(/@[a-zA-Z0-9_]+\s[mobil|motor]+\s[a-zA-Z]{1,}\s[0-9]*\s[a-zA-Z]+/)

          @array_nil = []
          @array_exist = []

          @number.each do |vehicle|
            @owner = vehicle[/\B@\S+/]
            @type = vehicle[/[mobil|motor]{5}/]
            @plat = vehicle[/[a-zA-Z]{1,}\s[0-9]*\s[a-zA-Z]+/]
  
            unless (@array_nil.include? @plat) || (@array_exist.include? @plat)
              check_user = @db.check_dupe_vehicle(@plat, @owner, @type)
              @dupe_check = check_user.size.zero? ? nil : check_user.first['ve_name']
              @dupe_check.nil? ? @array_nil.push(vehicle) : @array_exist.push(vehicle)
              @dupe_check.nil? ? @db.add_vehicle(@owner, @type, @plat) : @db.delete_vehicle(@owner, @type, @plat)
            end
          end
          add_vehicle unless @array_nil.empty?
          delete_vehicle unless @array_exist.empty?
        end

        def add_vehicle
          @list = @array_nil.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
          @bot.api.send_message(chat_id: @id, text: adding_vehicle(@list), parse_mode: 'HTML')
        end

        def delete_vehicle
          @list = @array_exist.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
          @bot.api.send_message(chat_id: @id, text: deleting_vehicle(@list), parse_mode: 'HTML')
        end
      end
    end
  end
