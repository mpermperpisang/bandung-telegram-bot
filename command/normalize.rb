module Bot
  class Command
    # untuk mengembalikan jam staging seu=suai jam server bot
    class Normalize < Command
      def check_text
        check_stg_empty if @txt.start_with?('/normalize')
      end

      def check_stg_empty
        @is_staging = Staging.new
        @send = SendMessage.new

        normalize_date unless @is_staging.empty?(@bot, @chatid, @staging, @username, @txt)
      end

      def normalize_date
        Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).define_ip

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
        EnvBash.load(ENV['DOWNLOAD_URL'] + '/helper/jenkins/exec_normalize.bash')
        @send.success_normalize_date(@id, @staging, @year_month_date, @time)
        @bot.api.send_message(@send.message)
      end
    end
  end
end
