require './message/message_text.rb'

module Bot
  class Command
    class Hi5 < Command
      @@reminder = BandungSnack.new
      @@user = User.new

      def bandung_hi5
        @@user.is_spammer?(@bot, @id, @message.from.username, @message, @command)
        if @@user.spam == false
          begin
            case (@space.strip)
            when nil, ""
              begin
                self.list_hi5_squad
              rescue
                @bot.api.send_message(chat_id: @id, text: "Tolong japri aku dulu yaa, Kak #{@message.from.username} buat tau list Hi5nya")
              end
            else
              team = ["wtb", "bbm", "art", "core", "disco", "bandung"]
              if team.include?((@space.strip).downcase)
                self.hi5_member((@space.strip).upcase)
              else
                @bot.api.send_message(chat_id: @id, text: msg_invalid_squad(@space.strip, @message.from.username), parse_mode: 'HTML')
              end
            end
          rescue
            self.list_hi5_squad
          end
        end
      end

      def list_hi5_squad
        @kb = [
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "WTB", callback_data: "wtb"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "BBM", callback_data: "bbm")
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "ART", callback_data: "art"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "CORE", callback_data: "core")
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "DISCO", callback_data: "disco"),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "Bandung", callback_data: "bandung")
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: "Email", callback_data: "email")
          ]
        ]
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @kb)

        @bot.api.send_message(chat_id: @message.from.id, text: choose_squad(@message.from.username), reply_markup: markup)
      end

      def add_member(command)
        team = ["wtb", "bbm", "art", "core", "disco", "bandung"]

        begin
          if team.include?((@@msg.squad_name).strip.downcase)
            unless @@user.is_admin?(@bot, @message.chat.id, @message.from.username)
              unless @symbol == nil || @symbol == ""
                #INI try to refactor
                Bot::DBConnect.new.check_hi5((@@msg.squad_name).strip, @symbol)
                @@reminder.gsub_duplicate_hi5

                name = @txt.scan(/\B@\S+/)
                name.each { |hi5_name|
                  case @@reminder.name
                  when nil, ""
                    Bot::DBConnect.new.check_hi5_bandung(hi5_name)
                    @@reminder.gsub_squad_hi5

                    case @@reminder.name
                    when nil, ""
                      Bot::DBConnect.new.add_hi5((@@msg.squad_name).strip, hi5_name)
                      @bot.api.send_message(chat_id: @message.from.id, text: msg_add_hi5((@@msg.squad_name).strip, hi5_name), parse_mode: 'HTML')
                    else
                      Bot::DBConnect.new.edit_hi5((@@msg.squad_name).strip, hi5_name)
                      @bot.api.send_message(chat_id: @message.from.id, text: msg_edit_hi5((@@msg.squad_name).strip, hi5_name), parse_mode: 'HTML')
                    end
                  else
                    Bot::DBConnect.new.delete_hi5((@@msg.squad_name).strip, hi5_name)
                    @bot.api.send_message(chat_id: @message.from.id, text: msg_delete_hi5((@@msg.squad_name).strip, hi5_name), parse_mode: 'HTML')
                  end
                }
              else
                @@user.is_spammer?(@bot, @id, @message.from.username, @message, @command)
                if @@user.spam == false
                  self.hi5_member((@space.strip).upcase)
                end
              end
            end
          else
            @bot.api.send_message(chat_id: @message.from.id, text: msg_invalid_squad((@@msg.squad_name).strip, @message.from.username), parse_mode: 'HTML')
          end
        rescue
          self.list_hi5_squad
          @bot.api.send_message(chat_id: @message.from.id, text: msg_invalid_hi5, parse_mode: 'HTML')
        end
      end

      def hi5_member(squad)
        result = Bot::DBConnect.new.bandung_hi5_squad(squad)
        count = result.count
        @@reminder.gsub_bandung_hi5

        if @@reminder.name == nil || @@reminder.name == ''
          hi5_name = empty_member(squad, @message.from.username)
        else
          hi5_name = @@reminder.name
        end

        if hi5_name =~ /kosong/
          @bot.api.send_message(chat_id: @message.from.id, text: "#{hi5_name}")
        else
          if squad.downcase == "bandung"
            @bot.api.send_message(chat_id: @id, text: list_hi5(squad, count)+"\n\nBy: <code>@#{@message.from.username}</code>", parse_mode: 'HTML')
            @bot.api.send_message(chat_id: @id, text: "#{hi5_name}")
          else
            @bot.api.send_message(chat_id: @message.from.id, text: list_hi5(squad, count), parse_mode: 'HTML')
            @bot.api.send_message(chat_id: @message.from.id, text: "<code>#{hi5_name}</code>", parse_mode: 'HTML')
          end
        end
      end

      def member_email
        Bot::DBConnect.new.bandung_email
        @@reminder.gsub_bandung_email
        
        @bot.api.send_message(chat_id: @message.from.id, text: "List email squad <b>BANDUNG</b>", parse_mode: 'HTML')
        @bot.api.send_message(chat_id: @message.from.id, text: "<code>#{@@reminder.hi5_email}</code>", parse_mode: 'HTML')
      end
    end
  end
end
