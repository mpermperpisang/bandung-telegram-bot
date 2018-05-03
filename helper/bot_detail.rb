<<<<<<< HEAD
# Untuk melihat detail bot
=======
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
module BotDetail
  def fullname
    case @token
    when ENV['TOKEN_BOOKING']
      ENV['NAME_BOOKING']
    when ENV['TOKEN_JENKINS']
      ENV['NAME_JENKINS']
<<<<<<< HEAD
=======
    when ENV['TOKEN_JENKINS_2']
      ENV['NAME_JENKINS_2']
    when ENV['TOKEN_JENKINS_3']
      ENV['NAME_JENKINS_3']
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
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
<<<<<<< HEAD
=======
    when ENV['TOKEN_JENKINS_2']
      ENV['BOT_JENKINS_2']
    when ENV['TOKEN_JENKINS_3']
      ENV['BOT_JENKINS_3']
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
    when ENV['TOKEN_TODO']
      ENV['BOT_TODO']
    when ENV['TOKEN_REMINDER']
      ENV['BOT_REMINDER']
    end
  end

  def connection
    case @type_status
    when :online
<<<<<<< HEAD
      'Online'
    when :offline
      'Offline'
=======
      "Online"
    when :offline
      "Offline"
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
    end
  end

  def help
    case @message
    when ENV['TOKEN_BOOKING']
<<<<<<< HEAD
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
    *You cannot use autocomplete for this command

    2. Cancel deploy branch request (group)
    /cancel_request branch_name
    Example: /cancel_request BBM-123-456-789
    *You cannot use autocomplete for this command

    3. Booking staging for hard code, deploy or testing (group)
    /booking_21, /booking_51 or /booking_103

    4. Done using staging (group)
    /done_21, /done_51 or /done_103

    5. See staging book status (group)
    /status

    6. See list of deploy branch request (group)
    /list_request

    🐾 You can not use another staging than 21, 51 or 103 (under development)"
  end

  def help_jenkins
    "
    1. Deploy in specific staging (group)
    /deploy_staging_number branch_name
    Example: /deploy_21 BBM-123, /deploy_51 BBM-456, or
    /deploy_103 BBM-789
    *You cannot use autocomplete for this command

    2. Lock release in staging (group)
    /lock_staging_number
    Example: /lock_21, /lock_51 or /lock_103

    3. Start BackBurner in staging (group)
    /start_staging_number
    Example: /start_21, /start_51 or /start_103

    4. Restart BackBurner in staging (group)
    /restart_staging_number
    Example: /restart_21, /restart_51 or /restart_103

    5. Stop BackBurner in staging (group)
    /stop_staging_number
    Example: /stop_21, /stop_51 or /stop_103

    6. Migrate database in staging (group)
    /migrate_staging_number
    Example: /migrate_21, /migrate_51 or /migrate_103

    7. Reindex data in staging (group)
    /reindex_staging_number
    Example: /reindex_21, /reindex_51 or /reindex_103

    8. Manual assets precompile (group)
    /precompile_staging_number
    Example: /precompile_21, /precompile_51 or /precompile_103

    9. Normalize staging date
    /normalize_staging_number
    Example: /normalize_21, /normalize_51, or /normalize_103

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
    *You cannot use autocomplete for this command

    2. Edit people schedule temporarily (group)
    /edit day @username
    Example: /edit tue @#{ENV['BOT_REMINDER']}
    *You cannot use autocomplete for this command

    3. Change snack schedule permanently (group)
    /change day @username
    Example: /change wed @#{ENV['BOT_REMINDER']}
    *You cannot use autocomplete for this command

    4. Delete people from schedule (group)
    /delete @username
    Example: /delete @#{ENV['BOT_REMINDER']}
    *You cannot use autocomplete for this command

    5. Cancel people from bring snack (group)
    /cancel @username
    Example: /cancel @#{ENV['BOT_REMINDER']}
    *You cannot use autocomplete for this command

    6. People brought the snack (group)
    /done or /done @username
    Example: /done, /done @#{ENV['BOT_REMINDER']}
    *You cannot use autocomplete for this command

    7. Free people from snack schedule (group)
    /holiday command or /holiday @username
    Example: /holiday @all, /holiday @#{ENV['BOT_REMINDER']}
    *You cannot use autocomplete for this command

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

    2. Displaying marketplace poin result (group)
    /show

    3. Note for retrospective (private)
    /retro sprint_number retro_comment
    Example: /retro 100 retro is good

    4. Displaying retrospective result (group)
    /list_retro sprint_number
    Example: /list_retro 100

    🐾 Only admin, PM and APM can show the poin"
=======
      "
      1. Requesting deploy a branch (group)
      /deploy_request branch_name
      Example: /deploy_request BBM-123-456-789
      *You cannot use autocomplete for this command

      2. Cancel deploy branch request (group)
      /cancel_request branch_name
      Example: /cancel_request BBM-123-456-789
      *You cannot use autocomplete for this command

      3. Booking staging for hard code, deploy or testing (group)
      /booking_21, /booking_51 or /booking_103

      4. Done using staging (group)
      /done_21, /done_51 or /done_103

      5. See staging book status (group)
      /status

      6. See list of deploy branch request (group)
      /list_request

      🐾 You can not use another staging than 21, 51 or 103 (under development)"
    when ENV['TOKEN_JENKINS'], ENV['TOKEN_JENKINS_2'], ENV['TOKEN_JENKINS_3']
      "
      1. Deploy in specific staging (group)
      /deploy_staging_number branch_name
      Example: /deploy_21 BBM-123, /deploy_51 BBM-456, or
      /deploy_103 BBM-789
      *You cannot use autocomplete for this command

      2. Lock release in staging (group)
      /lock_staging_number
      Example: /lock_21, /lock_51 or /lock_103

      3. Start BackBurner in staging (group)
      /start_staging_number
      Example: /start_21, /start_51 or /start_103

      4. Restart BackBurner in staging (group)
      /restart_staging_number
      Example: /restart_21, /restart_51 or /restart_103

      5. Stop BackBurner in staging (group)
      /stop_staging_number
      Example: /stop_21, /stop_51 or /stop_103

      6. Migrate database in staging (group)
      /migrate_staging_number
      Example: /migrate_21, /migrate_51 or /migrate_103

      7. Reindex data in staging (group)
      /reindex_staging_number
      Example: /reindex_21, /reindex_51 or /reindex_103

      8. Manual assets precompile (group)
      /precompile_staging_number
      Example: /precompile_21, /precompile_51 or /precompile_103

      9. Normalize staging date
      /normalize_staging_number
      Example: /normalize_21, /normalize_51, or /normalize_103

      🐾 You can use another staging, not only 21, 51 or 103"
    when ENV['TOKEN_TODO']
      "
      1. Send poin with fibonnaci number (private)
      1/2, 1, 2, 3, 5, 8, 13, 20, 40, 100, kopi, unlimited
      0 (zero) is default number so it will not displaying

      2. Displaying marketplace poin result (group)
      /show

      3. Note for retrospective (private)
      /retro sprint_number retro_comment
      Example: /retro 100 retro is good

      4. Displaying retrospective result (group)
      /list_retro sprint_number
      Example: /list_retro 100

      🐾 Only admin, PM and APM can show the poin"
    when ENV['TOKEN_REMINDER']
      "
      When you try to add, edit or change snack schedule, please
      read carefully.

      - Day format
      only use mon, tue, wed, thu or fri

      1. Add people to snack schedule (group)
      /add day @username
      Example: /add mon @#{ENV['BOT_REMINDER']}
      *You cannot use autocomplete for this command

      2. Edit people schedule temporarily (group)
      /edit day @username
      Example: /edit tue @#{ENV['BOT_REMINDER']}
      *You cannot use autocomplete for this command

      3. Change snack schedule permanently (group)
      /change day @username
      Example: /change wed @#{ENV['BOT_REMINDER']}
      *You cannot use autocomplete for this command

      4. Delete people from schedule (group)
      /delete @username
      Example: /delete @#{ENV['BOT_REMINDER']}
      *You cannot use autocomplete for this command

      5. Cancel people from bring snack (group)
      /cancel @username
      Example: /cancel @#{ENV['BOT_REMINDER']}
      *You cannot use autocomplete for this command

      6. People brought the snack (group)
      /done or /done @username
      Example: /done, /done @#{ENV['BOT_REMINDER']}
      *You cannot use autocomplete for this command

      7. Free people from snack schedule (group)
      /holiday command or /holiday @username
      Example: /holiday @all, /holiday @#{ENV['BOT_REMINDER']}
      *You cannot use autocomplete for this command

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
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
  end
end
