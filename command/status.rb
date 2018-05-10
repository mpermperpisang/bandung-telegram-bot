module Bot
  class Command
    # untuk melihat status staging
    class Status < Command
      def check_text
        check_stg_empty if @txt.start_with?('/status')
      end

      def check_stg_empty
        @is_staging = Staging.new

        check_staging unless @is_staging.empty?(@bot, @chatid, @staging, @username, @command)
      end

      def check_staging
        @db = Connection.new
        @send = SendMessage.new

        staging = [*1..132].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@id, @username, @staging)
        staging == 'new' ? @bot.api.send_message(@send.message) : status_staging
      end

      def status_staging
        name = @txt.scan(/\d+/)
        File.open('./require_ruby.rb', 'w+') do |f|
          f.puts("Status staging\n\n")
          name.each do |stg_name|
            user = @db.status_staging(stg_name)
            if user.size.zero?
              @bot.api.send_message(chat_id: @chatid, text: stg_not_exist(stg_name), parse_mode: 'HTML')
            else
              f.puts("<code>staging#{stg_name}</code> : <b>" + user.first['book_status'].upcase + '</b>')
              f.puts(user.first['book_branch'])
              f.puts('@' + user.first['book_name'] + "\n\n")
            end
          end
        end
        show_status
      end

      def show_status
        list_status_stg = File.read('./require_ruby.rb')
        @bot.api.send_message(chat_id: @chatid, text: list_status_stg, parse_mode: 'HTML') if list_status_stg =~ /:/
      end
    end
  end
end
