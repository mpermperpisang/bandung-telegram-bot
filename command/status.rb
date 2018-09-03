module Bot
  class Command
    # untuk melihat status staging
    class Status < Command
      def check_text
        check_stg_empty if @txt.start_with?("/status@#{ENV['BOT_BOOKING']}")
      end

      def check_stg_empty
        @is_staging = Staging.new

        check_staging unless @is_staging.empty?(@bot, @chatid, @staging, @username, @command)
      end

      def check_staging
        @db = Connection.new
        @send = SendMessage.new

        staging = [*1..134].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@chatid, @username, @staging)
        staging == 'new' ? @bot.api.send_message(@send.message) : status_staging
      end

      def status_staging
        name = @txt.scan(/\d+/)
        @array = []
        @array.push("Status staging\n\n")

        name.each do |stg_name|
          @user = @db.status_staging(stg_name)
          if @user.size.zero?
            @bot.api.send_message(chat_id: @chatid, text: stg_not_exist(stg_name), parse_mode: 'HTML')
          else
            @user.each do |row|
              if row['book_status'] == "booked"
                mention = "\n@#{mention}" + row['book_name']
              elsif row['book_status'] == "done"
                mention = "<pre>@#{mention}" + row['book_name'] + "</pre>"
              end
              @array.push("<code>staging#{stg_name}</code> : <b>" + row['book_status'].upcase + "</b>\n" +
              row['book_branch'] + "#{mention}\n\n")
            end
          end
        end
        show_status if @array.to_s != "[\"Status staging\\n\\n\"]"
      end

      def show_status
        @status_stg = @array.to_s.delete('["').delete('"]').gsub('\n\n', "\n\n").gsub(', ', '').gsub('\n', "\n")
        @bot.api.send_message(chat_id: @chatid, text: @status_stg, parse_mode: 'HTML')
      end
    end
  end
end
