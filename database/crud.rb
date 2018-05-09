# Koneksi ke database
class Connection
  def initialize
    @msg = MessageText.new
    @msg.connection
    @host = @msg.host
    @user = @msg.username
    @pword = @msg.password

    @client = Mysql2::Client.new(host: @host.to_s, username: @user.to_s, password: @pword.to_s)
    @client.query('use bbm_squad')
  end

  def check_booked(stg)
    @client.query("select book_status from booking_staging where book_staging='#{stg}'")
  end

  def message_chat_id
    @client.query('select distinct chat_id from deploy_staging')
  end

  def done_booking(stg)
    @client.query("select book_name, book_from_id from booking_staging where book_staging='#{stg}'")
  end

  def done_staging(stg)
    @client.query("update booking_staging set book_status='done' where book_staging='#{stg}' and book_status='booked'")
  end

  def list_requester(branch)
    @client.query("select deploy_request from deploy_staging where deploy_branch='#{branch.strip}'
    and deploy_status='requesting'")
  end

  def list_request
    @client.query("select deploy_request, deploy_branch from deploy_staging where deploy_status='requesting'
    order by deploy_date asc")
  end

  def check_queue(branch)
    @client.query("select deploy_branch from deploy_staging where deploy_branch='#{branch.strip}'")
  end

  def list_queue(name, chat, ip_stg, staging, branch, type)
    date = DateTime.now
    now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_
    #{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"
    @client.query("update deploy_staging set deployer='#{name}', deploy_status='queueing', deploy_date='#{now}',
    deploy_ip='#{ip_stg}',
    deploy_stg='#{staging}', deploy_type='#{type}', chat_id='#{chat}' where deploy_branch='#{branch.strip}'
    and (deploy_status<>'queueing')")
  end

  def insert_queue(name, chat, ip_stg, staging, branch, type)
    date = DateTime.now
    now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_
    #{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"
    @client.query("insert into deploy_staging (deploy_branch, deploy_status, deployer, deploy_date, deploy_ip,
    deploy_stg,deploy_type, chat_id)
    values ('#{branch.strip}', 'queueing', '#{name}', '#{now}', '#{ip_stg}', '#{staging}', '#{type}', '#{chat}')")
  end

  def number_queue_cap
    @client.query("select deploy_stg from deploy_staging where deploy_status='queueing'
    and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start'
    or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc")
  end

  def number_queue_rake
    @client.query("select deploy_stg from deploy_staging where deploy_status='queueing'
    and (deploy_type='db:migrate' or deploy_type='elasticsearch:reindex_index' or deploy_type='assets:precompile')
    order by deploy_date asc")
  end

  def list_deployment
    @client.query("select deploy_date, deploy_branch, deploy_stg, deployer from deploy_staging
    where deploy_status='caping' and deploy_type='deploy'
    order by deploy_date desc")
  end

  def deploy_duration(duration, branch)
    @client.query("update deploy_staging set deploy_duration='#{duration}'
    where deploy_type='deploy' and deploy_branch='#{branch.strip}'")
  end

  def status_booking(stg)
    @client.query("select book_status, book_name from booking_staging where book_staging='#{stg}'")
  end

  def book_staging(name, id, stg)
    @client.query("update booking_staging set book_name='#{name}', book_from_id='#{id}', book_status='booked'
    where book_staging='#{stg}' and book_status='done'")
  end

  def check_deploy(branch)
    @client.query("select deploy_branch from deploy_staging where deploy_branch='#{branch.strip}'")
  end

  def deploy(branch, name)
    date = DateTime.now
    now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_
    #{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"
    @client.query("insert into deploy_staging (deploy_branch, deploy_status, deploy_request, deploy_date)
    values('#{branch.strip}', 'requesting', '#{name}', '#{now}')")
  end

  def update_deploy(branch, name)
    date = DateTime.now
    now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_
    #{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"
    @client.query("update deploy_staging set deploy_request='#{name}', deploy_status='requesting', deploy_date='#{now}'
    where deploy_branch='#{branch.strip}'")
  end

  def check_deploy_req(branch)
    @client.query("select deploy_branch from deploy_staging where deploy_branch='#{branch.strip}'
    and deploy_status='requesting'")
  end

  def cancel_deploy(branch)
    @client.query("update deploy_staging set deploy_status='cancelled' where deploy_branch='#{branch.strip}'")
  end

  def status_staging
    File.open('./require_ruby.rb', 'w+') do |f|
      f.puts("PIC -\nstaging21 : ")
      @client.query("select book_status from booking_staging where book_staging='21'").each do |row|
        f.puts(row.to_s)
      end

      @client.query("select book_branch from booking_staging where book_staging='21'").each do |row|
        f.puts(row.to_s)
      end

      @client.query("select book_name from booking_staging where book_staging='21'").each do |row|
        f.puts("@#{row}")
      end

      f.puts("\nPIC Muhammad Rezaldy\nstaging51 : ")
      @client.query("select book_status from booking_staging where book_staging='51'").each do |row|
        f.puts(row.to_s)
      end

      @client.query("select book_branch from booking_staging where book_staging='51'").each do |row|
        f.puts(row.to_s)
      end

      @client.query("select book_name from booking_staging where book_staging='51'").each do |row|
        f.puts("@#{row}")
      end

      f.puts("\nPIC Ferawati Hartanti Pratiwi\nstaging103 : ")
      @client.query("select book_status from booking_staging where book_staging='103'").each do |row|
        f.puts(row.to_s)
      end

      @client.query("select book_branch from booking_staging where book_staging='103'").each do |row|
        f.puts(row.to_s)
      end

      @client.query("select book_name from booking_staging where book_staging='103'").each do |row|
        f.puts("@#{row}")
      end
    end
  end

  def update_id_closed(id)
    @client.query("update squad_marketplace set chat_id_market='#{id}', status_market='closed' where id_market>0")
  end

  def list_poin
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select member_market, poin_market from squad_marketplace where status_market='closed'
      and poin_market<>'0' order by member_market asc").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def check_poin_open(user)
    @client.query("select status_market from squad_marketplace where status_market='open' and member_market='@#{user}'")
  end

  def check_member_market(user)
    @client.query("select member_market from squad_marketplace where member_market='@#{user}'")
  end

  def show_message_id
    @client.query("select distinct message_id_market from squad_marketplace where message_id_market<>0")
  end

  def update_market_closed(poin, user)
    @client.query("update squad_marketplace set poin_market='#{poin}', status_market='closed'
    where member_market='@#{user}'")
  end

  def list_accepted_poin
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select member_market from squad_marketplace where poin_market<>'0' and status_market='closed'").each do |row|
        f.puts(row)
      end
    end
  end

  def chat_market
    @client.query("select distinct chat_id_market from squad_marketplace where message_id_market<>0")
  end

  def id_get_poin(user, id)
    @client.query("update squad_marketplace set from_id_market='#{id}'
    where member_market='@#{user}' and from_id_market<>'#{id}'")
  end

  def message_from_id
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select distinct from_id_market from squad_marketplace where poin_market<>'0'").each do |row|
        f.puts(row)
      end
    end
  end

  def update_market_open
    @client.query("update squad_marketplace set poin_market='0', status_market='open' where id_market>0")
  end

  def update_message_id(id)
    @client.query("update squad_marketplace set message_id_market='#{id}' where id_market>0")
  end

  def add_people(day, name)
    @client.query("insert into bandung_snack values ('#{day.strip}', '#{day.strip}', '#{name}', 'belum')")
  end

  def checking_spam(name, com)
    @client.query("select bot_attempt from bot_spam where spammer_name='#{name}' and bot_command='#{com}'")
  end

  def saving_spam(name, com)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select bot_command from bot_spam where bot_command='#{com}'").each do |row|
        f.puts(row)
      end
    end

    list = File.read('./require_ruby.rb')
    name1 = list.gsub('{"bot_command"=>"', '')
    name2 = name1.gsub('"}', '')
    spam = name2.gsub("\n", '')

    case spam
    when nil, ""
      attempt = 1
      @client.query("insert bot_spam values (#{attempt}, '#{name}', '#{com}')")
    else
      File.open('./require_ruby.rb', 'w+') do |f|
        @client.query("select spammer_name from bot_spam where spammer_name='#{name}' and bot_command='#{com}'").each do |row|
          f.puts(row)
        end
      end

      list = File.read('./require_ruby.rb')
      name1 = list.gsub('{"spammer_name"=>"', '')
      name2 = name1.gsub('"}', '')
      spam_name = name2.gsub("\n", '')

      case spam_name
      when nil, ""
        @client.query("update bot_spam set bot_attempt=1, spammer_name='#{name}' where bot_command='#{com}'")
      else
        File.open('./require_ruby.rb', 'w+') do |f|
          @client.query("select bot_attempt from bot_spam where spammer_name='#{name}' and bot_command='#{com}'").each do |row|
            f.puts(row)
          end
        end

        line = File.read('././require_ruby.rb')
        att1 = line.gsub('{"bot_attempt"=>', "")
        att2 = att1.gsub('}', "")
        att = att2.gsub("\n", "")

        attempt = att.to_i + 1

        @client.query("update bot_spam set bot_attempt=#{attempt} where spammer_name='#{name}' and bot_command='#{com}'")
      end
    end
  end

  def check_people(name)
    @client.query("select name from bandung_snack where name='#{name}'")
  end

  def edit_people(day, name)
    @client.query("update bandung_snack set day='#{day.strip}' where name='#{name}'")
  end

  def delete_people(name)
    @client.query("delete from bandung_snack where name='#{name}'")
  end

  def check_day(name)
    @client.query("select day from bandung_snack where name='#{name}'")
  end

  def check_done(name)
    @client.query("select status from bandung_snack where name='#{name}'")
  end

  def done_people(day, name)
    @client.query("update bandung_snack set status='sudah' where name='#{name}' and day='#{day}' and status='belum'")
  end

  def remind_people(day)
    @client.query("select name from bandung_snack where day='#{day}' and status='belum'")
  end

  def reset_reminder(day)
    @client.query("update bandung_snack set status='belum' where day<>'#{day}'")
  end

  def people_holiday(day)
    @client.query("select name from bandung_snack where day='#{day}' and status='sudah'")
  end

  def cancel_people(name)
    @client.query("update bandung_snack set status='belum' where name='#{name}'")
  end

  def holiday_people(name)
    @client.query("update bandung_snack set status='libur' where name='#{name}'")
  end

  def holiday_all(day)
    @client.query("update bandung_snack set status='libur' where day='#{day}'")
  end

  def change_people(day, name)
    @client.query("update bandung_snack set fix_day='#{day.strip}', day='#{day.strip}' where name='#{name}'")
  end

  def normal_snack
    @client.query("update bandung_snack set day='mon' where fix_day<>day and name<>'' and fix_day='mon'")
    @client.query("update bandung_snack set day='tue' where fix_day<>day and name<>'' and fix_day='tue'")
    @client.query("update bandung_snack set day='wed' where fix_day<>day and name<>'' and fix_day='wed'")
    @client.query("update bandung_snack set day='thu' where fix_day<>day and name<>'' and fix_day='thu'")
    @client.query("update bandung_snack set day='fri' where fix_day<>day and name<>'' and fix_day='fri'")
  end
end
