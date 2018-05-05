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
end
