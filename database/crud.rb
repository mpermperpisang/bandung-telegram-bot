<<<<<<< HEAD
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

  def list_requester(branch)
    @client.query("select deploy_request from deploy_staging where deploy_branch='#{branch.strip}'
    and deploy_status='requesting'")
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
    deploy_stg='#{staging}', deploy_type='#{type}', chat_id='#{chat}' where deploy_branch='#{branch}'
    and (deploy_status<>'queueing')")
  end

  def insert_queue(name, chat, ip_stg, staging, branch, type)
    date = DateTime.now
    now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_
    #{day.strftime('%H')}:#{day.strftime('%M')}:#{day.strftime('%S')}"
    @client.query("insert into deploy_staging (deploy_branch, deploy_status, deployer, deploy_date, deploy_ip,
    deploy_stg,deploy_type, chat_id)
    values ('#{branch}', 'queueing', '#{name}', '#{now}', '#{ip_stg}', '#{staging}', '#{type}', '#{chat}')")
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
    where deploy_type='deploy' and deploy_branch='#{branch}'")
=======
class Connection
  def db_connect(host, user, password)
    @client = Mysql2::Client.new(:host => "#{host}", :username => "#{user}", :password => "#{password}")
    @client.query("use bbm_squad")
  end

  def add_people(day, name)
    @client.query("insert into bandung_snack values ('#{day}', '#{day}', '#{name}', 'belum')")
  end

  def edit_people(day, name)
    @client.query("update bandung_snack set day='#{day}' where name='#{name}'")
  end

  def change_people(day, name)
    @client.query("update bandung_snack set fix_day='#{day}', day='#{day}' where name='#{name}'")
  end

  def delete_people(name)
    @client.query("delete from bandung_snack where name='#{name}'")
  end

  def delete_hi5(squad, name)
    @client.query("delete from bandung_hi5 where hi_name='#{name}' and hi_squad='#{squad}'")
  end

  def delete_member_hi5(name)
    @client.query("delete from bandung_hi5 where hi_name='#{name}'")
  end

  def done_people(day, name)
    @client.query("update bandung_snack set status='sudah' where name='#{name}' and day='#{day}' and status='belum'")
  end

  def cancel_people(name)
    @client.query("update bandung_snack set status='belum' where name='#{name}'")
  end

  def book_staging(name, id, staging)
    @client.query("update booking_staging set book_name='#{name}', book_from_id='#{id}', book_status='booked' where book_staging='#{staging}' and book_status='done'")
  end

  def done_staging(staging)
    @client.query("update booking_staging set book_status='done' where book_staging='#{staging}' and book_status='booked'")
  end

  def staging_deploy(staging, branch)
    @client.query("update booking_staging set book_branch='#{branch}' where book_staging='#{staging}'")
  end

  def holiday(name)
    @client.query("update bandung_snack set status='libur' where name='#{name}'")
  end

  def deploy_duration(duration, branch)
    @client.query("update deploy_staging set deploy_duration='#{duration}' where deploy_type='deploy' and deploy_branch='#{branch}'")
  end

  def holiday_all(day)
    @client.query("update bandung_snack set status='libur' where day='#{day}'")
  end

  def todo_list(name, task)
    @client.query("insert into squad_todo (name, task, status) values ('#{name}', '#{task}', 'undone')")
  end

  def list_queue(name, chat, ip, staging, branch, type)
    date = DateTime.now
    now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_#{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"
    @client.query("update deploy_staging set deployer='#{name}', deploy_status='queueing', deploy_date='#{now}', deploy_ip='#{ip}', deploy_stg='#{staging}', deploy_type='#{type}', chat_id='#{chat}' where deploy_branch='#{branch}' and (deploy_status<>'queueing')")
  end

  def done_task(task)
    @client.query("update squad_todo set status='done' where task='#{task}'")
  end

  def deploy(branch, name)
    date = DateTime.now
    now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_#{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"
    @client.query("insert into deploy_staging (deploy_branch, deploy_status, deploy_request, deploy_date) values('#{branch}', 'requesting', '#{name}', '#{now}')")
  end

  def deployed(branch)
    @client.query("update deploy_staging set deploy_status='deployed' where deploy_branch='#{branch}'")
  end

  def update_deploy(branch, name)
    date = DateTime.now
    now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_#{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"
    @client.query("update deploy_staging set deploy_request='#{name}', deploy_status='requesting', deploy_date='#{now}' where deploy_branch='#{branch}'")
  end

  def normal_snack
    @client.query("update bandung_snack set day='mon' where fix_day<>day and name<>'' and fix_day='mon'")
    @client.query("update bandung_snack set day='tue' where fix_day<>day and name<>'' and fix_day='tue'")
    @client.query("update bandung_snack set day='wed' where fix_day<>day and name<>'' and fix_day='wed'")
    @client.query("update bandung_snack set day='thu' where fix_day<>day and name<>'' and fix_day='thu'")
    @client.query("update bandung_snack set day='fri' where fix_day<>day and name<>'' and fix_day='fri'")
  end

  def book_room(name, room)
    @client.query("update booking_room set book_status='booked', book_name='#{name}' where book_room='#{room}'")
  end

  def book_room_done(name)
    @client.query("update booking_room set book_status='done' where book_name='#{name}'")
  end

  def cancel_deploy(branch)
    @client.query("update deploy_staging set deploy_status='cancelled' where deploy_branch='#{branch}'")
  end

  def add_hi5(squad, name)
    @client.query("insert into bandung_hi5 (hi_name, hi_squad) values ('#{name}', '#{squad.upcase}')")
  end

  def edit_hi5(squad, name)
    @client.query("update bandung_hi5 set hi_squad='#{squad.upcase}' where hi_name='#{name}' and hi_squad='BANDUNG'")
  end

  def save_retro(sprint, retro, name)
    @client.query("insert into squad_retro (sprint_retro, list_retro, member_retro, status_retro) values ('#{sprint}', '#{retro}', '#{name}', 'open')")
  end

  def save_booking(name, room, date_now, from, to, fromm, tom)
    date = DateTime.now
    today = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date_now}"

    @client.query("insert into booking_room (book_name, book_room, book_status, book_date, book_from, book_to) values ('#{name}', '#{room}', 'booked', '#{today}', '#{book_from}', '#{book_to}')")
  end

  def insert_queue(name, chat, ip, staging, branch, type)
    date = DateTime.now
    now = "#{date.strftime('%Y')}-#{date.strftime('%m')}-#{date.strftime('%d')}_#{date.strftime('%H')}:#{date.strftime('%M')}:#{date.strftime('%S')}"
    @client.query("insert into deploy_staging (deploy_branch, deploy_status, deployer, deploy_date, deploy_ip, deploy_stg, deploy_type, chat_id) values ('#{branch}', 'queueing', '#{name}', '#{now}', '#{ip}', '#{staging}', '#{type}', '#{chat}')")
  end

  def update_retro(sprint)
    @client.query("update squad_retro set status_retro='closed' where sprint_retro='#{sprint}' and status_retro='open' and id_retro>0")
  end

  def open_retro(sprint)
    @client.query("update squad_retro set status_retro='open' where sprint_retro='#{sprint}' and status_retro='closed' and id_retro>0")
  end

  def update_market_open
    @client.query("update squad_marketplace set poin_market='0', status_market='open' where id_market>0")
  end

  def id_get_poin(user, id)
    @client.query("update squad_marketplace set from_id_market='#{id}' where member_market='@#{user}' and from_id_market<>'#{id}'")
  end

  def update_market_closed(poin, user)
    @client.query("update squad_marketplace set poin_market='#{poin}', status_market='closed' where member_market='@#{user}'")
  end

  def update_message_id(id)
    @client.query("update squad_marketplace set message_id_market='#{id}' where id_market>0")
  end

  def update_chat_id(id)
    @client.query("update squad_marketplace set chat_id_market='#{id}' where id_market>0")
  end

  def number_queue_cap
    @client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and (deploy_type='deploy' or deploy_type='lock:release' or deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc")
  end

  def number_queue_lock
    @client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and deploy_type='lock:release' order by deploy_date asc")
  end

  def number_queue_backburner
    @client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and (deploy_type='backburner:start' or deploy_type='backburner:restart' or deploy_type='backburner:stop') order by deploy_date asc")
  end

  def number_queue_rake
    @client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and (deploy_type='db:migrate' or deploy_type='elasticsearch:reindex_index' or deploy_type='assets:precompile') order by deploy_date asc")
  end

  def number_queue_reindex
    @client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and deploy_type='elasticsearch:reindex_index' order by deploy_date asc")
  end

  def number_queue_precompile
    @client.query("select deploy_stg from deploy_staging where deploy_status='queueing' and deploy_type='assets:precompile' order by deploy_date asc")
  end

  def save_spam(name, command)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select bot_command from bot_spam where bot_command='#{command}'").each do |row|
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
      @client.query("insert bot_spam values (#{attempt}, '#{name}', '#{command}')")
    else
      File.open('./require_ruby.rb', 'w+') do |f|
        @client.query("select spammer_name from bot_spam where spammer_name='#{name}' and bot_command='#{command}'").each do |row|
          f.puts(row)
        end
      end

      list = File.read('./require_ruby.rb')
      name1 = list.gsub('{"spammer_name"=>"', '')
      name2 = name1.gsub('"}', '')
      spam_name = name2.gsub("\n", '')

      case spam_name
      when nil, ""
        @client.query("update bot_spam set bot_attempt=1, spammer_name='#{name}' where bot_command='#{command}'")
      else
        File.open('./require_ruby.rb', 'w+') do |f|
          @client.query("select bot_attempt from bot_spam where spammer_name='#{name}' and bot_command='#{command}'").each do |row|
            f.puts(row)
          end
        end

        line = File.read('././require_ruby.rb')
        att1 = line.gsub('{"bot_attempt"=>', "")
        att2 = att1.gsub('}', "")
        att = att2.gsub("\n", "")

        attempt = att.to_i + 1

        @client.query("update bot_spam set bot_attempt=#{attempt} where spammer_name='#{name}' and bot_command='#{command}'")
      end
    end
  end

  def check_spam(name, command)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select bot_attempt from bot_spam where spammer_name='#{name}' and bot_command='#{command}'").each do |row|
        f.puts(row)
      end
    end
  end

  def invalid_day(name)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select day from bandung_snack where name='#{name}'").each do |row|
        f.puts(row)
      end
    end
  end

  def check_people(name)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select name from bandung_snack where name='#{name}'").each do |row|
        f.puts(row)
      end
    end
  end

  def check_hi5(squad, name)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select hi_name from bandung_hi5 where hi_name='#{name}' and hi_squad='#{squad}'").each do |row|
        f.puts(row)
      end
    end
  end

  def check_hi5_bandung(name)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select hi_name from bandung_hi5 where hi_name='#{name}' and hi_squad='Bandung'").each do |row|
        f.puts(row)
      end
    end
  end

  def check_done(name)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select status from bandung_snack where name='#{name}'").each do |row|
        f.puts(row)
      end
    end
  end

  def remind_people(day)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select name from bandung_snack where day='#{day}' and status='belum'").each do |row|
        f.puts(row)
      end
    end
  end

  def reset_reminder(day)
    @client.query("update bandung_snack set status='belum' where day<>'#{day}'")
  end

  def people_holiday(day)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select name from bandung_snack where day='#{day}' and status='sudah'").each do |row|
        f.puts("i#{row}")
      end
    end
  end

  def snack_schedule(day)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select name from bandung_snack where fix_day='#{day}'").each do |row|
        f.puts(row)
      end
    end
  end

  def count_schedule(day)
    @client.query("select count(name) from bandung_snack where fix_day='#{day}';")
  end

  def status_booking(book_staging)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select book_status, book_name from booking_staging where book_staging='#{book_staging}'").each do |row|
        f.puts(row)
      end
    end
  end

  def status_staging
    File.open('./require_ruby.rb', 'w+') do |f|
      f.puts("PIC Abdul Manan Maksum\nstaging21 : ")
      @client.query("select book_status from booking_staging where book_staging='21'").each do |row|
        f.puts("#{row}")
      end

      @client.query("select book_branch from booking_staging where book_staging='21'").each do |row|
        f.puts("#{row}")
      end

      @client.query("select book_name from booking_staging where book_staging='21'").each do |row|
        f.puts("@#{row}")
      end

      f.puts("\nPIC Muhammad Rezaldy\nstaging51 : ")
      @client.query("select book_status from booking_staging where book_staging='51'").each do |row|
        f.puts("#{row}")
      end

      @client.query("select book_branch from booking_staging where book_staging='51'").each do |row|
        f.puts("#{row}")
      end

      @client.query("select book_name from booking_staging where book_staging='51'").each do |row|
        f.puts("@#{row}")
      end

      f.puts("\nPIC Ferawati Hartanti Pratiwi\nstaging103 : ")
      @client.query("select book_status from booking_staging where book_staging='103'").each do |row|
        f.puts("#{row}")
      end

      @client.query("select book_branch from booking_staging where book_staging='103'").each do |row|
        f.puts("#{row}")
      end

      @client.query("select book_name from booking_staging where book_staging='103'").each do |row|
        f.puts("@#{row}")
      end
    end
  end

  def recall_list(name)
    File.open('./require_ruby.rb', 'w+') do |f|
      i = 1
      @client.query("select task from squad_todo where name='#{name}' and status='undone'").each do |row|
        f.puts("#{i}. #{row}")
        i = i + 1
      end
    end
  end

  def check_list(task)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select status from squad_todo where task='#{task}'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def bandung_hi5
    File.open('./require_ruby.rb', 'w+') do |f|
      f.puts("ART")
      @client.query("select hi_name from bandung_hi5 where hi_squad='ART' order by hi_name").each do |row|
        f.puts(row)
      end

      f.puts("BBM")
      @client.query("select hi_name from bandung_hi5 where hi_squad='BBM' order by hi_name").each do |row|
        f.puts(row)
      end

      f.puts("WTB")
      @client.query("select hi_name from bandung_hi5 where hi_squad='WTB' order by hi_name").each do |row|
        f.puts(row)
      end

      f.puts("CORE")
      @client.query("select hi_name from bandung_hi5 where hi_squad='CORE' order by hi_name").each do |row|
        f.puts(row)
      end

      f.puts("DISCO")
      @client.query("select hi_name from bandung_hi5 where hi_squad='DISCO' order by hi_name").each do |row|
        f.puts(row)
      end

      f.puts("BANDUNG a.k.a belum ada squad")
      @client.query("select hi_name from bandung_hi5 where hi_squad='BANDUNG' order by hi_name").each do |row|
        f.puts(row)
      end
    end
  end

  def bandung_hi5_squad(squad)
    if squad.upcase == "BANDUNG"
      File.open('./require_ruby.rb', 'w+') do |f|
        @client.query("select distinct hi_name from bandung_hi5 order by hi_name").each do |row|
          f.puts(row)
        end
      end
    else
      File.open('./require_ruby.rb', 'w+') do |f|
        @client.query("select hi_name from bandung_hi5 where hi_squad='#{squad.upcase}' order by hi_name").each do |row|
          f.puts(row)
        end
      end
    end
  end

  def bandung_email
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select distinct hi_email from bandung_hi5 order by hi_email").each do |row|
        f.puts(row)
      end
    end
  end

  def squad_hi5(squad)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select hi_name from bandung_hi5 where hi_squad='#{squad.upcase}' order by hi_name").each do |row|
        f.puts(row)
      end
    end
  end

  def list_request
    File.open('./require_ruby.rb', 'w+') do |f|
      i = 1
      @client.query("select deploy_request, deploy_branch from deploy_staging where deploy_status='requesting' order by deploy_date asc").each do |row|
        f.puts("#{i}. #{row}")
        i = i + 1
      end
    end
  end

  def list_requester(branch)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select deploy_request from deploy_staging where deploy_branch='#{branch}' and deploy_status='requesting'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def list_deployed(branch)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select deploy_request from deploy_staging where deploy_branch='#{branch}' and deploy_status='deployed'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def check_deploy(branch)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select deploy_branch from deploy_staging where deploy_branch='#{branch}'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def check_room_status(room)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select book_status from booking_room where book_room='#{room}'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def check_room_book(room)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select book_name from booking_room where book_room='#{room}'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def done_booking(staging)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select book_name, book_from_id from booking_staging where book_staging='#{staging}'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def check_booked(staging)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select book_status from booking_staging where book_staging='#{staging}'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def check_day(name)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select day from bandung_snack where name='#{name}'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def deploy_branch(branch)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select deploy_branch from deploy_staging where deploy_status='requesting' order by deploy_date asc limit #{branch}, 1").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def list_retrospective(sprint)
    File.open('./require_ruby.rb', 'w+') do |f|
      i = 1
      @client.query("select list_retro from squad_retro where sprint_retro='#{sprint}' and status_retro='open'").each do |row|
        f.puts("#{i}. #{row}")
        i = i + 1
      end
    end
  end

  def check_poin_closed
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select status_market from squad_marketplace where status_market='closed'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def check_poin_open(user)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select status_market from squad_marketplace where status_market='open' and member_market='@#{user}'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def check_branch_queue(branch)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select deploy_branch from deploy_staging where deploy_branch='#{branch}'").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def list_poin
    @client.query("update squad_marketplace set status_market='closed' where id_market>0")

    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select member_market, poin_market from squad_marketplace where status_market='closed' and poin_market<>'0' order by member_market asc").each do |row|
        f.puts("#{row}")
      end
    end
  end

  def list_deployment
    File.open('./require_ruby.rb', 'w+') do |f|
      i = 1
      @client.query("select deploy_date, deploy_branch, deploy_stg, deployer from deploy_staging where deploy_status='caping' and deploy_type='deploy' order by deploy_date desc").each do |row|
        f.puts("#{i}. #{row}")
        i = i + 1
      end
    end
  end

  def message_chat_id
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select distinct chat_id from deploy_staging").each do |row|
        f.puts(row)
      end
    end
  end

  def message_from_id
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select distinct from_id_market from squad_marketplace where poin_market<>'0'").each do |row|
        f.puts(row)
      end
    end
  end

  def check_member_market(user)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select member_market from squad_marketplace where member_market='@#{user}'").each do |row|
        f.puts(row)
      end
    end
  end

  def show_message_id
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select distinct message_id_market from squad_marketplace where message_id_market<>0").each do |row|
        f.puts(row)
      end
    end
  end

  def list_accepted_poin
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select member_market from squad_marketplace where poin_market<>'0' and status_market='closed'").each do |row|
        f.puts(row)
      end
    end
  end

  def chat_market
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select distinct chat_id_market from squad_marketplace where message_id_market<>0").each do |row|
        f.puts(row)
      end
    end
  end

  def check_deploy_req(branch)
    File.open('./require_ruby.rb', 'w+') do |f|
      @client.query("select deploy_branch from deploy_staging where deploy_branch='#{branch}' and deploy_status='requesting'").each do |row|
        f.puts(row)
      end
    end
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
  end
end
