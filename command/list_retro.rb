require './helper/bbm_todo.rb'

module Bot
  class Command
    class ListRetro < Command
      @@todo = BBMTodoList.new
      @@user = User.new

      def list_retro
        unless @@user.is_pm?(@bot, @message.chat.id, @message.from.username)
          case @staging
          when nil, "", false
            @bot.api.send_message(chat_id: @message.chat.id, text: empty_sprint_list(@message.from.username), parse_mode: 'HTML')
          else
            #INI try to refactor
            Bot::DBConnect.new.retrospective(@staging)
            @@todo.retrospective

            case @@todo.retro
            when nil, ""
              @bot.api.send_message(chat_id: @message.from.id, text: empty_retro)
            else
              unless @staging == nil || @staging == "" || @staging == false
                @bot.api.send_message(chat_id: @id, text: msg_list_retro(@staging, @@todo.retro)) #PM
                @bot.api.send_message(chat_id: @message.from.id, text: msg_send_retro)
              else
                @bot.api.send_message(chat_id: @message.chat.id, text: empty_sprint_list(@message.from.username), parse_mode: 'HTML')
              end
            end
            Bot::DBConnect.new.update_retro(@staging)
          end
        end
      end
    end
  end
end
