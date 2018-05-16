require 'telegram/bot'
require 'mysql2'
require 'envbash'
require 'dotenv'
require 'net/ssh'
require 'net/scp'

token = '364913393:AAFCJX2v0syzQaF8632xmX1HD-xpUprIyuo'
#@chat_id = '-192957413' #testing bot local
#@chat_id='-317359831' #testing bot staging
#@chat_id='-310122724' #bbm-dana bot announcements

bot = Telegram::Bot::Client.new(token)

begin
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "bukalapak")
    client.query("use bbm_squad")
    File.open('/home/bukalapak/bot/require/helper_rake.rb', 'w+') do |f|
      client.query("select chat_id from deploy_staging where deploy_status='queueing' order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end
    end

    line = File.read('/home/bukalapak/bot/require/helper_rake.rb')
    line1 = line.gsub('{"chat_id"=>"', '')
    line2 = line1.gsub("\n", '')
    p @chat_id = line2.gsub('"}', '')

    File.open('/home/bukalapak/bot/require/ruby_rake.rb', 'w+') do |f|
      client.query("select deploy_ip from deploy_staging where deploy_status='queueing' and (deploy_type='db:migrate' or deploy_type='elasticsearch:reindex_index' or deploy_type='assets:precompile') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end

      client.query("select deploy_branch from deploy_staging where deploy_status='queueing' and (deploy_type='db:migrate' or deploy_type='elasticsearch:reindex_index' or deploy_type='assets:precompile') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end

      client.query("select deploy_type from deploy_staging where deploy_status='queueing' and (deploy_type='db:migrate' or deploy_type='elasticsearch:reindex_index' or deploy_type='assets:precompile') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end

      client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and (deploy_type='db:migrate' or deploy_type='elasticsearch:reindex_index' or deploy_type='assets:precompile') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end
    end

    line = File.read('/home/bukalapak/bot/require/ruby_rake.rb')
    line1 = line.gsub('{"deploy_ip"=>"', 'ip_staging=')
    line2 = line1.gsub('{"deploy_branch"=>"', 'staging_branch=')
    line3 = line2.gsub('{"deploy_type"=>"', 'type=')
    line4 = line3.gsub('{"deploy_stg"=>"', 'staging=')
    @var = line4.gsub('"}', '')

    File.open("/home/bukalapak/bot/require/ruby_rake.rb", "w+") do |f|
      f.puts(@var)
    end

    File.open('/home/bukalapak/bot/require/helper_rake.rb', 'w+') do |f|
      client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and (deploy_type='db:migrate' or deploy_type='elasticsearch:reindex_index' or deploy_type='assets:precompile') order by deploy_date asc limit 1").each do |row|
        f.puts(row)
      end
    end

    line = File.read('/home/bukalapak/bot/require/helper_rake.rb')
    line1 = line.gsub('{"deploy_stg"=>"', '')
    line2 = line1.gsub('"}', '')
    p @staging = line2.gsub("\n", '')

    unless @staging == nil || @staging == ""
      bot.api.send_message(chat_id: @chat_id, text: "Begin exec rake action <b>staging#{@staging}</b>", parse_mode: 'HTML')

      File.open('/home/bukalapak/bot/require/helper_rake.rb', 'w+') do |f|
        client.query("select deploy_branch from deploy_staging where deploy_status='queueing' and (deploy_type='db:migrate' or deploy_type='elasticsearch:reindex_index' or deploy_type='assets:precompile') order by deploy_date asc limit 1").each do |row|
          f.puts(row)
        end
      end

      line = File.read('/home/bukalapak/bot/require/helper_rake.rb')
      line1 = line.gsub('{"deploy_branch"=>"', '')
      line2 = line1.gsub('"}', '')
      @staging_branch = line2.gsub("\n", '')

      date = DateTime.now
      @now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_#{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"

      client.query("update deploy_staging set deploy_status='rakeing', deploy_date='#{@now}' where deploy_branch='#{@staging_branch}' and (deploy_status='queueing' or deploy_status='rakeed')")

      p File.read('/home/bukalapak/bot/require/ruby_rake.rb')
      EnvBash.load("/home/bukalapak/bot/helper/jenkins/exec_rake.bash")

      p @staging
      if @staging != "103"
        Net::SSH.start("staging#{@staging}.vm", "bukalapak", :password => "bukalapak") do |session|
          begin
            session.scp.download! "/home/bukalapak/deploy/log/rake.log", "/home/bukalapak/bot/log"
          rescue
            session.scp.download! "/home/bukalapak/current/log/rake.log", "/home/bukalapak/bot/log"
          end
        end

        bot.api.send_document(chat_id: @chat_id, document: Faraday::UploadIO.new('/home/bukalapak/bot/log/rake.log', 'text/plain'))
        text = File.read('/home/bukalapak/bot/log/rake.log')
      else
        begin
          bot.api.send_document(chat_id: @chat_id, document: Faraday::UploadIO.new('/home/bukalapak/deploy/log/rake.log', 'text/plain'))
          text = File.read('/home/bukalapak/deploy/log/rake.log')
        rescue
          bot.api.send_document(chat_id: @chat_id, document: Faraday::UploadIO.new('/home/bukalapak/current/log/rake.log', 'text/plain'))
          text = File.read('/home/bukalapak/current/log/rake.log')
        end
      end

      if text =~ /DEPLOY FAILED/ || text =~ /rake aborted!/ || text =~ /cap aborted!/
        status = "FAILED"
      else
        status = "SUCCESS"
      end

      begin
        client.query("update deploy_staging set deploy_status='rakeed' where deploy_branch='#{@staging_branch}' and deploy_status='rakeing'")

        File.open('/home/bukalapak/bot/require/helper_rake.rb', 'w+') do |f|
          client.query("select deployer from deploy_staging where deploy_status='rakeed' order by deploy_date desc limit 1").each do |row|
            f.puts(row)
          end
        end

        line = File.read('/home/bukalapak/bot/require/helper_rake.rb')
        line1 = line.gsub('{"deployer"=>"', '')
        line2 = line1.gsub('"}', '')
        @deployer = "@"+line2.gsub("\n", '')
      rescue
        @deployer = "None"
      end

      bot.api.send_message(chat_id: @chat_id, text: "Rake action <code>staging#{@staging}</code> is <b>#{status}</b>\nDeployed by #{@deployer}", parse_mode: 'HTML')
    end
rescue Exception => e
  bot.api.send_message(chat_id: "276637527", text: "There is an error rake cron, please check @mpermperpisang")
  raise e
end
