module Bot
  class Command
    class Normal < Command
      @@reminder = BandungSnack.new
      @@user = User.new

      def normal_snack
        @@user.is_spammer?(@bot, @id, @message.from.username, @message, @command)
        if @@user.spam == false
          Bot::DBConnect.new.normal_snack
          @bot.api.send_message(chat_id: @id, text: msg_normal_snack, parse_mode: 'HTML')
        end
      end
    end
  end
end
