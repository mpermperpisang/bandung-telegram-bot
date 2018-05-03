require './message/message_text.rb'

module Bot
  class Command
    class Retro < Command
      def squad_retro
        case @staging
        when nil, "", false
          @bot.api.send_message(chat_id: @message.chat.id, text: empty_sprint(@message.from.username), parse_mode: 'HTML')
        else
          unless @staging == nil || @staging == "" || @staging == false || @sprint == nil || @sprint == ""
            Bot::DBConnect.new.save_retro(@staging, @sprint, @message.from.username)
            @bot.api.send_message(chat_id: @message.from.id, text: msg_save_retro(@staging))

            Bot::DBConnect.new.open_retro(@staging)
          else
            @bot.api.send_message(chat_id: @message.chat.id, text: msg_invalid_sprint, parse_mode: 'HTML')
          end
        end
      end

      def retro_group
        @bot.api.send_message(chat_id: @id, text: msg_rescue_retro(@message.from.username))
      end
    end
  end
end
