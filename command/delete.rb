module Bot
  class Command
    class Delete < Command
      @@reminder = BandungSnack.new
      @@user = User.new
      @@snack = Snack.new

      def delete_snack
        @@user.is_spammer?(@bot, @id, @message.from.username, @message, @command)
        if @@user.spam == false
          unless @@user.is_admin?(@bot, @id, @message.from.username)
            unless @@snack.is_empty?(@bot, @id, @message, @symbol, @command)
              name = @txt.scan(/\B@\S+/)
              name.each { |delete_name|
                user = Bot::DBConnect.new.check_people(delete_name)
                name = user.empty? ? nil : user[0]['name']

                case name
                when nil, ""
                  @bot.api.send_message(chat_id: @id, text: empty_people(delete_name), parse_mode: 'HTML')
                else
                  Bot::DBConnect.new.delete_people(delete_name)
                  @bot.api.send_message(chat_id: @id, text: msg_delete_people(delete_name))
                end
              }
            end
          end
        end
      end
    end
  end
end
