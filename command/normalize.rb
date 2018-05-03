module Bot
  class Command
    class Normalize < Command
      @@staging = Staging.new

      def normal_date
        unless @@staging.is_empty?(@bot, @id, @message, @base_command, @staging)
          self.normalize_staging
        end
      end

      def normalize_staging
        case @staging
        when "21"
          ip = "192.168.114.182"
        when "51"
          ip = "192.168.34.46"
        when "103"
          ip = "192.168.35.95"
        else
          ip = "staging#{staging}.vm"
        end

        date = DateTime.now
        year_month_date = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}"
        time = "#{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"

        var = ["ip_staging=#{ip}", "date=#{year_month_date}", "time=#{time}"]
        File.open("./require_ruby.rb", "w+") do |f|
            f.puts(var)
        end

        EnvBash.load(ENV['DOWNLOAD_URL']+"/helper/jenkins/exec_normalize.bash")
        @bot.api.send_message(chat_id: @message.chat.id, text: normalize(@staging, "#{year_month_date} #{time}"), parse_mode: 'HTML')
      end
    end
  end
end
