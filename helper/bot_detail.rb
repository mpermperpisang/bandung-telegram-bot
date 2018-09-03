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
    <b>/deploy_request@#{ENV['BOT_BOOKING']} branch_name</b>

    2. Cancel deploy branch request (group)
    <b>/cancel_request@#{ENV['BOT_BOOKING']} branch_name</b>

    3. Booking staging for hard code, deploy or testing (group)
    <b>/booking@#{ENV['BOT_BOOKING']} staging_number</b>

    4. Done using staging (group)
    <b>/done@#{ENV['BOT_BOOKING']} staging_number</b>

    5. See staging book status (group)
    <b>/status@#{ENV['BOT_BOOKING']} staging_number1 staging_number2 staging_number3</b>

    6. See list of deploy branch request (group)
    <b>/list_request@#{ENV['BOT_BOOKING']}</b>

    🐾 You can use another staging, not only DANA staging"
  end

  def help_jenkins
    "
    1. Deploy in specific staging (group)
    <b>/deploy@#{ENV['BOT_JENKINS']} staging_number branch_name</b>

    2. Lock release in staging (group)
    <b>/lock@#{ENV['BOT_JENKINS']} staging_number</b>

    3. Start BackBurner in staging (group)
    <b>/start@#{ENV['BOT_JENKINS']} staging_number</b>

    4. Restart BackBurner in staging (group)
    <b>/restart@#{ENV['BOT_JENKINS']} staging_number</b>

    5. Stop BackBurner in staging (group)
    <b>/stop@#{ENV['BOT_JENKINS']} staging_number</b>

    6. Migrate database in staging (group)
    <b>/migrate@#{ENV['BOT_JENKINS']} staging_number</b>

    7. Reindex data in staging (group)
    <b>/reindex@#{ENV['BOT_JENKINS']} staging_number</b>

    8. Manual assets precompile (group)
    <b>/precompile@#{ENV['BOT_JENKINS']} staging_number</b>

    9. Normalize staging date (group)
    <b>/normalize@#{ENV['BOT_JENKINS']} staging_number</b>

    🐾 You can use another staging, not only DANA staging"
  end

  def help_snack
    "
    When you try to add, edit or change snack schedule, please
    read carefully.

    - Day format
    only use <b>mon</b>, <b>tue</b>, <b>wed</b>, <b>thu</b> or <b>fri</b>

    1. Add people to snack schedule (group)
    <b>/add@#{ENV['BOT_REMINDER']} day1 @username day2 @username</b>

    2. Change people schedule TEMPORARILY (group)
    <b>/edit@#{ENV['BOT_REMINDER']} day1 @username day2 @username</b>

    3. Change snack schedule PERMANENTLY (group)
    <b>/move@#{ENV['BOT_REMINDER']} day1 @username day2 @username</b>

    4. Delete people from schedule (group)
    <b>/delete@#{ENV['BOT_REMINDER']} @username1 @username2</b>

    5. Cancel people from bring snack (group)
    <b>/cancel@#{ENV['BOT_REMINDER']} @username1 @username2</b>

    6. People brought the snack (group)
    <b>/done@#{ENV['BOT_REMINDER']} or /done@#{ENV['BOT_REMINDER']} @username</b>

    7. Free people from snack schedule (group)
    <b>/holiday@#{ENV['BOT_REMINDER']} @all or /holiday@#{ENV['BOT_REMINDER']} @username1 @username2</b>

    8. Remind snack schedule (group)
    <b>/reminder@#{ENV['BOT_REMINDER']}</b>

    9. Bring back normal schedule (group)
    <b>/normal@#{ENV['BOT_REMINDER']}</b>

    10. List HI5 of Bandung squad member (both)
    <b>/hi5@#{ENV['BOT_REMINDER']}</b>

    11. List vehicles of members (both)
    <b>/plat@#{ENV['BOT_REMINDER']}</b>

    <a href='https://bukalapak.atlassian.net/wiki/spaces/BS/pages/347046333/Snack+Schedule'>CHECK SCHEDULE</a>

    🐾 Only admin/PM/APM/EM/QAM can do add, edit, change,
    delete & holiday 😎"
  end

  def help_todo
    "
    1. Displaying poin in inline keyboard (private)
    <b>/keyboard</b>

    2. Displaying marketplace poin result (group)
    <b>/show@#{ENV['BOT_TODO']}</b>

    🐾 Only admin, PM and APM can show the poin"
  end
end
