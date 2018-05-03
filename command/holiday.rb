require './helper/bot_day.rb'

module Bot
  class Command
    class Holiday < Command
      @@dday = Day.new
      @@reminder = BandungSnack.new
      @@user = User.new
      @@snack = Snack.new

      def holiday_snack
        @@user.is_spammer?(@bot, @id, @message.from.username, @message, @command)
        if @@user.spam == false
          unless @@user.is_admin?(@bot, @id, @message.from.username)
            @@dday.read_today
            self.update_holiday
          end
        end
      end

      def update_holiday
        begin
          username = @symbol.strip
        rescue
          username = @symbol
        end

        unless @@snack.is_empty?(@bot, @id, @message, username, @command)
          name = @txt.scan(/\B@\S+/)
          name.each { |holi_name|
            case holi_name
            when "@all"
              Bot::DBConnect.new.holiday_all(@@dday.hari)
              @bot.api.send_message(chat_id: @id, text: msg_holiday_all)
            else
              holi_day = Bot::DBConnect.new.invalid_day(holi_name)
              day = holi_day.empty? ? nil : holi_day[0]['day']
              @@dday.read_today

              if(day == @@dday.hari)
                holi_user = Bot::DBConnect.new.check_people(holi_name)
                name = holi_user.empty? ? nil : holi_user[0]['name']

                case name
                when nil, ""
                  @bot.api.send_message(chat_id: @id, text: empty_people(holi_name), parse_mode: 'HTML')
                else
                  Bot::DBConnect.new.holiday_people(holi_name)
                  @bot.api.send_message(chat_id: @id, text: msg_holiday_people(holi_name), parse_mode: 'HTML')
                end
              else
                Bot::Command::DoneSnack.new(@token, @id, @bot, @message, @txt).reminder_done(holi_name)
              end
            end
          }
        end
      end
    end
  end
end
