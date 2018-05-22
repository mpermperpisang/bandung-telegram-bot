require 'telegram/bot'
require 'mysql2'
require 'envbash'
require 'dotenv'
require 'net/ssh'
require 'net/scp'

token = '364913393:AAFCJX2v0syzQaF8632xmX1HD-xpUprIyuo'

bot = Telegram::Bot::Client.new(token)

begin
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "bukalapak")
    client.query("use bbm_squad")
    File.open('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb', 'w+') do |f|
      client.query("select chat_id from deploy_staging where deploy_status='queueing' order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end
    end

    line = File.read('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb')
    line1 = line.gsub('{"chat_id"=>"', '')
    line2 = line1.gsub("\n", '')
    p @chat_id = line2.gsub('"}', '')

    File.open('/home/bukalapak/bandung-telegram-bot/require/ruby_cap.rb', 'w+') do |f|
      client.query("select deploy_ip from deploy_staging where deploy_status='queueing' and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end

      client.query("select deploy_branch from deploy_staging where deploy_status='queueing' and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end

      client.query("select deploy_type from deploy_staging where deploy_status='queueing' and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end

      client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end
    end

    line = File.read('/home/bukalapak/bandung-telegram-bot/require/ruby_cap.rb')
    line1 = line.gsub('{"deploy_ip"=>"', 'ip_staging=')
    line2 = line1.gsub('{"deploy_branch"=>"', 'staging_branch=')
    line3 = line2.gsub('{"deploy_type"=>"', 'type=')
    line4 = line3.gsub('{"deploy_stg"=>"', 'staging=')
    @var = line4.gsub('"}', '')

    File.open("/home/bukalapak/bandung-telegram-bot/require/ruby_cap.rb", "w+") do |f|
      f.puts(@var)
    end

    File.open('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb', 'w+') do |f|
      client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end
    end

    line = File.read('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb')
    line1 = line.gsub('{"deploy_stg"=>"', '')
    line2 = line1.gsub('"}', '')
    p @staging = line2.gsub("\n", '')

    File.open('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb', 'w+') do |f|
      client.query("select deploy_type from deploy_staging where deploy_status='queueing' and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end
    end

    line = File.read('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb')
    line1 = line.gsub('{"deploy_type"=>"', '')
    line2 = line1.gsub('"}', '')
    @deploy_type = line2.gsub("\n", '')

    unless @staging == nil || @staging == ""
      bot.api.send_message(chat_id: @chat_id, text: "Begin exec cap staging action <b>staging#{@staging}</b>", parse_mode: 'HTML')

      File.open('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb', 'w+') do |f|
        client.query("select deploy_branch from deploy_staging where deploy_status='queueing' and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc limit 1").each do |row|
          f.puts(row)
        end
      end

      line = File.read('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb')
      line1 = line.gsub('{"deploy_branch"=>"', '')
      line2 = line1.gsub('"}', '')
      @staging_branch = line2.gsub("\n", '')

      File.open('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb', 'w+') do |f|
        client.query("select deploy_ip from deploy_staging where deploy_status='queueing' and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc limit 1").each do |row|
          f.puts(row)
        end
      end

      line = File.read('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb')
      line1 = line.gsub('{"deploy_ip"=>"', '')
      line2 = line1.gsub('"}', '')
      @staging_ip = line2.gsub("\n", '')

      date = DateTime.now
      @now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_#{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"

      client.query("update deploy_staging set deploy_status='caping', deploy_date='#{@now}' where deploy_branch='#{@staging_branch}' and (deploy_status='queueing' or deploy_status='caped')")

      p File.read('/home/bukalapak/bandung-telegram-bot/require/ruby_cap.rb')
      begin
        EnvBash.load("/home/bukalapak/bandung-telegram-bot/helper/jenkins/exec_cap_deploy.bash")
      rescue
        EnvBash.load("/home/bukalapak/bandung-telegram-bot/helper/jenkins/exec_cap_current.bash")
      end

      p @staging
      if @staging != "103"
        Net::SSH.start("#{@staging_ip}", "bukalapak", :password => "bukalapak") do |session|
          begin
            session.scp.download! "/home/bukalapak/deploy/log/cap.log", "/home/bukalapak/bandung-telegram-bot/log"
          rescue
            session.scp.download! "/home/bukalapak/current/log/cap.log", "/home/bukalapak/bandung-telegram-bot/log"
          end
        end

        bot.api.send_document(chat_id: @chat_id, document: Faraday::UploadIO.new('/home/bukalapak/bandung-telegram-bot/log/cap.log', 'text/plain'))
        text = File.read('/home/bukalapak/bandung-telegram-bot/log/cap.log')
      else
        begin
          bot.api.send_document(chat_id: @chat_id, document: Faraday::UploadIO.new('/home/bukalapak/deploy/log/cap.log', 'text/plain'))
          text = File.read('/home/bukalapak/deploy/log/cap.log')
        rescue
          bot.api.send_document(chat_id: @chat_id, document: Faraday::UploadIO.new('/home/bukalapak/current/log/cap.log', 'text/plain'))
          text = File.read('/home/bukalapak/current/log/cap.log')
        end
      end

      if text =~ /DEPLOY FAILED/ || text =~ /rake aborted!/ || text =~ /cap aborted!/
        status = "FAILED"
      else
        status = "SUCCESS"

        if @deploy_type == 'deploy'
          client.query("update booking_staging set book_branch='#{@staging_branch}' where book_staging='#{@staging}'")
        end
      end

      begin
        client.query("update deploy_staging set deploy_status='caped' where deploy_branch='#{@staging_branch}' and deploy_status='caping'")

        File.open('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb', 'w+') do |f|
          client.query("select deployer from deploy_staging where deploy_status='caped' and deploy_branch='#{@staging_branch}' order by deploy_date desc limit 1").each do |row|
            f.puts(row)
          end
        end

        line = File.read('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb')
        line1 = line.gsub('{"deployer"=>"', '')
        line2 = line1.gsub('"}', '')

        case line2
        when nil, "", "-\n"
          @deployer = "None"
        else
          @deployer = "@"+line2.gsub("\n", '')
        end

        File.open('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb', 'w+') do |f|
          client.query("select deploy_request from deploy_staging where deploy_status='caped' and deploy_branch='#{@staging_branch}' order by deploy_date desc limit 1").each do |row|
            f.puts(row)
          end
        end

        line = File.read('/home/bukalapak/bandung-telegram-bot/require/helper_cap.rb')
        line1 = line.gsub('{"deploy_request"=>"', '')
        line2 = line1.gsub('"}', '')

        case line2
        when nil, "", "-\n"
          @requester = "\nRequested by None"
        else
          @requester = "\nRequested by @"+line2.gsub("\n", '')
        end
      rescue
        @deployer = "None"
        @requester = "\nRequested by None"
      end

      bot.api.send_message(chat_id: @chat_id, text: "Cap action <code>staging#{@staging}</code> is <b>#{status}</b>\nDeployed by #{@deployer}#{@requester}", parse_mode: 'HTML')
    end
rescue Exception => e
  bot.api.send_message(chat_id: "276637527", text: "There is an error cap cron, please check @mpermperpisang")
  raise e
end
