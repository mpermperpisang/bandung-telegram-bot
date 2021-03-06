module Bot
  class Command
    # untuk mengembalikan jam staging seu=suai jam server bot
    class Normalize < Command
      def check_text
        check_stg_empty if @txt.start_with?('/normalize')
      end

      def check_stg_empty
        @is_staging = Staging.new

        check_new_stg unless @is_staging.empty?(@bot, @chatid, @staging, @username, @command)
      end

      def check_new_stg
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
        normalize_date
      end

      def normalize_date
        define_ip(@staging)

        date = DateTime.now
        @year_month_date = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}"
        @time = "#{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"

        var = ["ip_staging=#{@ip_stg}", "date=#{@year_month_date}", "time=#{@time}"]
        File.open('./require_ruby.rb', 'w+') do |f|
          f.puts(var)
        end
        run_normalize
      end

      def run_normalize
        @send = SendMessage.new

        EnvBash.load(ENV['DOWNLOAD_URL'] + '/helper/jenkins/exec_normalize.bash')
        @send.success_normalize_date(@chatid, @staging, @year_month_date, @time)
        @bot.api.send_message(@send.message)
      end
    end
  end
end
