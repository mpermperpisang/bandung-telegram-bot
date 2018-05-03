require './helper/bandung_snack.rb'
require './helper/bot_day.rb'

module Bot
  class Command
    class Edit < Command
      @@user = User.new
      @@reminder = BandungSnack.new
      @@dday = Day.new

      def edit_snack
        @@user.is_spammer?(@bot, @id, @message.from.username, @message, @command)
        if @@user.spam == false
          unless @@user.is_admin?(@bot, @id, @message.from.username)
            begin
              day_snack = @space.strip
            rescue
              day_snack = @space
            end

            day = ["mon", "tue", "wed", "thu", "fri"]

            unless @symbol == nil || @symbol == "" || day.none?{ |n| n == day_snack }
              user = Bot::DBConnect.new.check_people(@symbol)
              name = user.empty? ? nil : user[0]['name']

              case name
              when nil, ""
                @bot.api.send_message(chat_id: @id, text: empty_people(@symbol), parse_mode: 'HTML')
              else
                @@dday.read_day(@space.strip)
                Bot::DBConnect.new.edit_people(@space.strip, @symbol)
                @bot.api.send_message(chat_id: @id, text: msg_edit_people(@message.from.username, @symbol, @@dday.day_name), parse_mode: 'HTML')
              end
            else
              @bot.api.send_message(chat_id: @id, text: errorEditDay(@command), parse_mode: 'HTML')
            end
          end
        end
      end
    end
  end
end
