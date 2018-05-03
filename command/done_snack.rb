require './helper/bot_day.rb'

module Bot
  class Command
    class DoneSnack < Command
      @@reminder = BandungSnack.new
      @@dday = Day.new
      @@user = User.new

      def done_snack
        @@user.is_spammer?(@bot, @id, @message.from.username, @message, @command)
        if @@user.spam == false
          if @symbol == nil || @symbol == ""
            name = "@#{@message.from.username}"
          else
            name = @symbol
          end

          day_name = Bot::DBConnect.new.invalid_day(name)
          day = day_name.empty? ? nil : day_name[0]['day']
          @@dday.read_today

          if(day == @@dday.hari)
            self.update_done(day, name)
          else
            self.reminder_done(name)
          end
        end
      end

      def update_done(day, name)
        user = Bot::DBConnect.new.check_done(name)
        status = user.empty? ? nil : user[0]['status']

        case status
        when "sudah"
          @bot.api.send_message(chat_id: @id, text: msg_done_spam(@message.from.username, name), parse_mode: 'HTML')
        when "libur"
          @bot.api.send_message(chat_id: @id, text: msg_holiday_spam(@message.from.username, name), parse_mode: 'HTML')
        when "belum"
          Bot::DBConnect.new.done_people(day, name)
          @bot.api.send_message(chat_id: @id, text: msg_done_people(name))
        end
      end

      def reminder_done(name)
        user = Bot::DBConnect.new.check_people(name)
        reminder_name = user.empty? ? nil : user[0]['name']

        case reminder_name
        when nil, ""
          @bot.api.send_message(chat_id: @id, text: empty_people(name), parse_mode: 'HTML')
        else
          user = Bot::DBConnect.new.check_day(name)
          day = user.empty? ? nil : user[0]['day']
          
          @@dday.read_day(day)
          if name == nil || name == ""
            @bot.api.send_message(chat_id: @id, text: msg_reminder_schedule(@@dday.day_name, "@#{@message.from.username}"))
          else
            @bot.api.send_message(chat_id: @id, text: msg_reminder_schedule(@@dday.day_name, name))
          end
        end
      end
    end
  end
end
