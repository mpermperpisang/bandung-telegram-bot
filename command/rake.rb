module Bot
  class Command
    # untuk migrate database, reindex tabel dan asset precompile
    class Rake < Command
      def check_text
        check_stg_empty if @txt.start_with?('/migrate', '/reindex', '/precompile')
      end

      def check_stg_empty
        @is_staging = Staging.new

        rake_general unless @is_staging.empty?(@bot, @chatid, @staging, @username, @command)
      end

      def rake_general
        @send = SendMessage.new
        @db = Connection.new

        max_stg = @db.check_max_stg
        stg_number = max_stg.first['book_staging'].to_s.gsub('book_','')

        staging = [*1..stg_number.to_i].include?(@staging.to_i) ? @staging : 'new'

        @send.check_new_staging(@chatid, @username, @staging)
        if staging == 'new'
          @bot.api.send_message(@send.message)
          @db.add_new_staging(@staging)
        end
        check_user_request
      end

      def check_user_request
        Bot::Command::DeployStaging.new(@token, @chatid, @bot, @message, @txt).check_requester
      end
    end
  end
end
