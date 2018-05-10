# Untuk melihat detail bot
module BotDetail
  def fullname
    case @token
    when ENV['TOKEN_BOOKING']
      ENV['NAME_BOOKING']
    when ENV['TOKEN_JENKINS']
      ENV['NAME_JENKINS']
    when ENV['TOKEN_TODO']
      ENV['NAME_TODO']
    when ENV['TOKEN_REMINDER']
      ENV['NAME_REMINDER']
    end
  end

  def username
    case @name
    when ENV['TOKEN_BOOKING']
      ENV['BOT_BOOKING']
    when ENV['TOKEN_JENKINS']
      ENV['BOT_JENKINS']
    when ENV['TOKEN_TODO']
      ENV['BOT_TODO']
    when ENV['TOKEN_REMINDER']
      ENV['BOT_REMINDER']
    end
  end

  def connection
    case @type_status
    when :online
      'Online'
    when :offline
      'Offline'
    end
  end

  def help
    case @message
    when ENV['TOKEN_BOOKING']
      help_booking
    when ENV['TOKEN_JENKINS'], ENV['TOKEN_JENKINS_2'], ENV['TOKEN_JENKINS_3']
      help_jenkins
    when ENV['TOKEN_TODO']
      help_todo
    when ENV['TOKEN_REMINDER']
      help_snack
    end
  end

  def help_booking
    "
    1. Requesting deploy a branch (group)
    /deploy_request branch_name
    Example: /deploy_request BBM-123-456-789

    2. Cancel deploy branch request (group)
    /cancel_request branch_name
    Example: /cancel_request BBM-123-456-789

    3. Booking staging for hard code, deploy or testing (group)
    /booking (staging_number)
    Example: /booking 21, /booking 51 or /booking 103

    4. Done using staging (group)
    /done (staging_number)
    Example: /done 21, /done 51 or /done 103

    5. See staging book status (group)
    /status (staging_number)
    Example: /status 21 51 103

    6. See list of deploy branch request (group)
    /list_request

    🐾 You can use another staging, not only 21, 51 or 103"
  end

  def help_jenkins
    "
    1. Deploy in specific staging (group)
    /deploy (staging_number) (branch_name)
    Example: /deploy 21 BBM-123, /deploy 51 BBM-456, or
    /deploy 103 BBM-789

    2. Lock release in staging (group)
    /lock (staging_number)
    Example: /lock 21, /lock 51 or /lock 103

    3. Start BackBurner in staging (group)
    /start (staging_number)
    Example: /start 21, /start 51 or /start 103

    4. Restart BackBurner in staging (group)
    /restart (staging_number)
    Example: /restart 21, /restart 51 or /restart 103

    5. Stop BackBurner in staging (group)
    /stop (staging_number)
    Example: /stop 21, /stop 51 or /stop 103

    6. Migrate database in staging (group)
    /migrate (staging_number)
    Example: /migrate 21, /migrate 51 or /migrate 103

    7. Reindex data in staging (group)
    /reindex (staging_number)
    Example: /reindex 21, /reindex 51 or /reindex 103

    8. Manual assets precompile (group)
    /precompile (staging_number)
    Example: /precompile 21, /precompile 51 or /precompile 103

    9. Normalize staging date
    /normalize (staging_number)
    Example: /normalize 21, /normalize 51, or /normalize 103

    🐾 You can use another staging, not only 21, 51 or 103"
  end

  def help_snack
    "
    When you try to add, edit or change snack schedule, please
    read carefully.

    - Day format
    only use mon, tue, wed, thu or fri

    1. Add people to snack schedule (group)
    /add day @username
    Example: /add mon @#{ENV['BOT_REMINDER']}

    2. Edit people schedule temporarily (group)
    /edit day @username
    Example: /edit tue @#{ENV['BOT_REMINDER']}

    3. Change snack schedule permanently (group)
    /change day @username
    Example: /change wed @#{ENV['BOT_REMINDER']}

    4. Delete people from schedule (group)
    /delete @username
    Example: /delete @#{ENV['BOT_REMINDER']}

    5. Cancel people from bring snack (group)
    /cancel @username
    Example: /cancel @#{ENV['BOT_REMINDER']}

    6. People brought the snack (group)
    /done or /done @username
    Example: /done, /done @#{ENV['BOT_REMINDER']}

    7. Free people from snack schedule (group)
    /holiday command or /holiday @username
    Example: /holiday @all, /holiday @#{ENV['BOT_REMINDER']}

    8. Remind snack schedule (group)
    /reminder

    9. Bring back normal schedule (group)
    /normal

    10. List HI5 of Bandung squad member (both)
    /hi5

    <a href='https://bukalapak.atlassian.net/wiki/spaces/BS/pages/347046333/Snack+Schedule'>CHECK SCHEDULE</a>

    🐾 Only admin and PM can do add, edit, change, delete &
    holiday 😎"
  end

  def help_todo
    "
    1. Send poin with fibonnaci number (private)
    1/2, 1, 2, 3, 5, 8, 13, 20, 40, 100, kopi, unlimited
    0 (zero) is default number so it will not displaying

    2. Displaying poin in inline keyboard (private)
    /keyboard

    3. Displaying marketplace poin result (group)
    /show

    🐾 Only admin, PM and APM can show the poin"
  end
end
