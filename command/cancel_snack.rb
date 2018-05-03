require './is_true/snack.rb'

module Bot
  class Command
    class CancelSnack < Command
      @@reminder = BandungSnack.new
      @@snack = Snack.new
      @@user = User.new

      def cancel_snack
        @@user.is_spammer?(@bot, @id, @message.from.username, @message, @command)
        if @@user.spam == false
          unless @@snack.is_empty?(@bot, @id, @message, @symbol, @command)
            name = @txt.scan(/\B@\S+/)
            name.each { |cancel_name|
              user = Bot::DBConnect.new.check_people(cancel_name)
              name = user.empty? ? nil : user[0]['name']

              case name
              when nil, ""
                @bot.api.send_message(chat_id: @id, text: empty_people(cancel_name), parse_mode: 'HTML')
              else
                Bot::DBConnect.new.cancel_people(cancel_name)
                @bot.api.send_message(chat_id: @id, text: msg_cancel_people(cancel_name))
              end
            }
          end
        end
      end
    end
  end
end
