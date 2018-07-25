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
    /deploy_request@#{ENV['BOT_BOOKING']} (branch_name)
    Example: /deploy_request@#{ENV['BOT_BOOKING']} DANA-123-456-789

    2. Cancel deploy branch request (group)
    /cancel_request@#{ENV['BOT_BOOKING']} (branch_name)
    Example: /cancel_request@#{ENV['BOT_BOOKING']} DANA-123-456-789

    3. Booking staging for hard code, deploy or testing (group)
    /booking@#{ENV['BOT_BOOKING']} (staging_number)
    Example: /booking@#{ENV['BOT_BOOKING']} 21,
    /booking@#{ENV['BOT_BOOKING']} 51 or /booking@#{ENV['BOT_BOOKING']} 103

    4. Done using staging (group)
    /done@#{ENV['BOT_BOOKING']} (staging_number)
    Example: /done@#{ENV['BOT_BOOKING']} 21,
    /done@#{ENV['BOT_BOOKING']} 51 or /done@#{ENV['BOT_BOOKING']} 103

    5. See staging book status (group)
    /status@#{ENV['BOT_BOOKING']} (staging_number)
    Example: /status@#{ENV['BOT_BOOKING']} 21 51 103

    6. See list of deploy branch request (group)
    /list_request@#{ENV['BOT_BOOKING']}

    🐾 You can use another staging, not only 21, 51 or 103"
  end

  def help_jenkins
    "
    1. Deploy in specific staging (group)
    /deploy@#{ENV['BOT_JENKINS']} (staging_number) (branch_name)
    Example: /deploy@#{ENV['BOT_JENKINS']} 21 DANA-123,
    /deploy@#{ENV['BOT_JENKINS']} 51 DANA-456, or
    /deploy@#{ENV['BOT_JENKINS']} 103 DANA-789

    2. Lock release in staging (group)
    /lock@#{ENV['BOT_JENKINS']} (staging_number)
    Example: /lock@#{ENV['BOT_JENKINS']} 21,
    /lock@#{ENV['BOT_JENKINS']} 51 or /lock@#{ENV['BOT_JENKINS']} 103

    3. Start BackBurner in staging (group)
    /start@#{ENV['BOT_JENKINS']} (staging_number)
    Example: /start@#{ENV['BOT_JENKINS']} 21,
    /start@#{ENV['BOT_JENKINS']} 51 or /start@#{ENV['BOT_JENKINS']} 103

    4. Restart BackBurner in staging (group)
    /restart@#{ENV['BOT_JENKINS']} (staging_number)
    Example: /restart@#{ENV['BOT_JENKINS']} 21,
    /restart@#{ENV['BOT_JENKINS']} 51 or /restart@#{ENV['BOT_JENKINS']} 103

    5. Stop BackBurner in staging (group)
    /stop@#{ENV['BOT_JENKINS']} (staging_number)
    Example: /stop@#{ENV['BOT_JENKINS']} 21,
    /stop@#{ENV['BOT_JENKINS']} 51 or /stop@#{ENV['BOT_JENKINS']} 103

    6. Migrate database in staging (group)
    /migrate@#{ENV['BOT_JENKINS']} (staging_number)
    Example: /migrate@#{ENV['BOT_JENKINS']} 21,
    /migrate@#{ENV['BOT_JENKINS']} 51 or /migrate@#{ENV['BOT_JENKINS']} 103

    7. Reindex data in staging (group)
    /reindex@#{ENV['BOT_JENKINS']} (staging_number)
    Example: /reindex@#{ENV['BOT_JENKINS']} 21,
    /reindex@#{ENV['BOT_JENKINS']} 51 or /reindex@#{ENV['BOT_JENKINS']} 103

    8. Manual assets precompile (group)
    /precompile@#{ENV['BOT_JENKINS']} (staging_number)
    Example: /precompile@#{ENV['BOT_JENKINS']} 21,
    /precompile@#{ENV['BOT_JENKINS']} 51 or /precompile@#{ENV['BOT_JENKINS']} 103

    9. Normalize staging date (group)
    /normalize@#{ENV['BOT_JENKINS']} (staging_number)
    Example: /normalize@#{ENV['BOT_JENKINS']} 21,
    /normalize@#{ENV['BOT_JENKINS']} 51, or /normalize@#{ENV['BOT_JENKINS']} 103

    🐾 You can use another staging, not only 21, 51 or 103"
  end

  def help_snack
    "
    When you try to add, edit or change snack schedule, please
    read carefully.

    - Day format
    only use mon, tue, wed, thu or fri

    1. Add people to snack schedule (group)
    /add@#{ENV['BOT_REMINDER']} day @username
    Example: /add@#{ENV['BOT_REMINDER']} mon @#{ENV['BOT_REMINDER']}

    2. Edit people schedule temporarily (group)
    /edit@#{ENV['BOT_REMINDER']} day @username
    Example: /edit@#{ENV['BOT_REMINDER']} tue @#{ENV['BOT_REMINDER']}

    3. Change snack schedule permanently (group)
    /change@#{ENV['BOT_REMINDER']} day @username
    Example: /change@#{ENV['BOT_REMINDER']} wed @#{ENV['BOT_REMINDER']}

    4. Delete people from schedule (group)
    /delete@#{ENV['BOT_REMINDER']} @username
    Example: /delete@#{ENV['BOT_REMINDER']} @#{ENV['BOT_REMINDER']}

    5. Cancel people from bring snack (group)
    /cancel@#{ENV['BOT_REMINDER']} @username
    Example: /cancel@#{ENV['BOT_REMINDER']} @#{ENV['BOT_REMINDER']}

    6. People brought the snack (group)
    /done@#{ENV['BOT_REMINDER']} or /done@#{ENV['BOT_REMINDER']} @username
    Example: /done@#{ENV['BOT_REMINDER']}, /done@#{ENV['BOT_REMINDER']} @#{ENV['BOT_REMINDER']}

    7. Free people from snack schedule (group)
    /holiday@#{ENV['BOT_REMINDER']} command or /holiday@#{ENV['BOT_REMINDER']} @username
    Example: /holiday@#{ENV['BOT_REMINDER']} @all, /holiday@#{ENV['BOT_REMINDER']} @#{ENV['BOT_REMINDER']}

    8. Remind snack schedule (group)
    /reminder@#{ENV['BOT_REMINDER']}

    9. Bring back normal schedule (group)
    /normal@#{ENV['BOT_REMINDER']}

    10. List HI5 of Bandung squad member (both)
    /hi5@#{ENV['BOT_REMINDER']}

    <a href='https://bukalapak.atlassian.net/wiki/spaces/BS/pages/347046333/Snack+Schedule'>CHECK SCHEDULE</a>

    🐾 Only admin and PM can do add, edit, change, delete &
    holiday 😎"
  end

  def help_todo
    "
    1. Displaying poin in inline keyboard (private)
    /keyboard

    2. Displaying marketplace poin result (group)
    /show@#{ENV['BOT_TODO']}

    🐾 Only admin, PM and APM can show the poin"
  end
end
