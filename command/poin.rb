module Bot
  class Command
    class Poin < Command
      @@user = User.new
      @@todo = BBMTodoList.new

      def mplace
        @kb = [
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "1/2", callback_data: "1/2"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "1", callback_data: "1"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "2", callback_data: "2")
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "3", callback_data: "3"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "5", callback_data: "5"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "8", callback_data: "8")
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "13", callback_data: "13"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "20", callback_data: "20"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "40", callback_data: "40")
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "100", callback_data: "100"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "☕️", callback_data: "kopi"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "〰", callback_data: "unlimited")
          ]
        ]

        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @kb)
        @bot.api.send_message(chat_id: @message.from.id, text: "Pilih poin", reply_markup: markup)
      end

      def poin(poin)
        value = ["1/2", "1", "2", "3", "5", "8", "13", "20", "40", "100"]
        market = ["kopi", "unlimited"]
        reset = ["show"]

        if value.include?(poin) || market.include?(poin)
          #INI try to refactor
          Bot::DBConnect.new.check_poin_open(@message.from.username)
          @@todo.market_status

          if @@todo.market == nil || @@todo.market == ""
            Bot::DBConnect.new.check_member_market(@message.from.username)
            @@todo.list_member_market

            case @@todo.member_market
            when nil, "", "\n"
              @bot.api.send_message(chat_id: @message.from.id, text: not_member_market)
            else
              @bot.api.send_message(chat_id: @message.from.id, text: next_chance)
            end
          else
            if ENV['ENVIRONMENT'] == 'staging'
              @bot.api.send_message(chat_id: @message.from.id, text: accepted_poin)
            elsif ENV['ENVIRONMENT'] == 'local'
              @bot.api.send_message(chat_id: @message.from.id, text: accepted_poin)
            end

            Bot::DBConnect.new.show_message_id
            @@todo.market_message_id

            Bot::DBConnect.new.update_market_closed(poin, @message.from.username)

            unless @@todo.msg_market == nil || @@todo.msg_market == ""
              Bot::DBConnect.new.list_accepted_poin
              @@todo.list_member_poin

              Bot::DBConnect.new.chat_market
              @@todo.id_chat_market

              begin
                @bot.api.edit_message_text(chat_id: @id, message_id: @@todo.msg_market.to_i+3, text: done_poin(@@todo.list_poin))
              rescue
                begin
                  @bot.api.edit_message_text(chat_id: @id, message_id: @@todo.msg_market.to_i+4, text: done_poin(@@todo.list_poin))
                rescue Exception => e
                  @bot.api.send_message(chat_id: "276637527", text: "There is no message to edit, please check @mpermperpisang")
                  puts e
                end
              end
            end
          end
        elsif @txt == "0"
          @bot.api.send_message(chat_id: @message.chat.id, text: "0 adalah angka default, Kak")
        elsif reset.include?(poin)
          unless @@user.is_pm?(@bot, @message.from.id, @message.from.username)
            Bot::DBConnect.new.update_chat_id(@message.from.id)
            Bot::DBConnect.new.list_poin
            @@todo.poin

            unless @@todo.poin_market == nil || @@todo.poin_market == ""
              @bot.api.send_message(chat_id: @message.chat.id, text: list_poin_market(@@todo.poin_market)) #PM
            else
              @bot.api.send_message(chat_id: @message.chat.id, text: empty_poin)
            end

            Bot::DBConnect.new.message_from_id
            @@todo.chat_id_private

            @line = File.read('./require_ruby.rb')

            if @line == nil || @line == "" || @line == "\n"
              @bot.api.send_message(chat_id: @message.from.id, text: msg_new_poin)
            else
              @line.each_line do |id_private|
                case id_private
                when "284392817\n", "366569214\n"
                  @bot.api.send_message(chat_id: id_private, text: msg_new_poin)
                else
                  @bot.api.send_message(chat_id: id_private, text: msg_new_poin_member)
                end
              end
            end

            Bot::DBConnect.new.update_market_open
          end
        else
          @bot.api.send_message(chat_id: @message.chat.id, text: msg_fibonnaci)
        end
      end

      def poin_group
        @bot.api.send_message(chat_id: @id, text: msg_rescue_poin(@message.from.username))
      end

      def show_private
        @bot.api.send_message(chat_id: @message.from.id, text: msg_rescue_show(@command, @message.from.username), parse_mode: 'HTML')
      end
    end
  end
end
