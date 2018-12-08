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
    1. Requesting deploy a branch (GROUP)
    <b>/deploy_request@#{ENV['BOT_BOOKING']} branch_name</b>

    2. Cancel deploy branch request (GROUP)
    <b>/cancel_request@#{ENV['BOT_BOOKING']} branch_name</b>

    3. Booking staging for hard code, deploy or testing (GROUP)
    <b>/booking@#{ENV['BOT_BOOKING']} staging_number</b>

    4. Done using staging (GROUP)
    <b>/done@#{ENV['BOT_BOOKING']} staging_number</b>
    
    5. Add staging to squad (GROUP)
    <b>/add_staging@#{ENV['BOT_BOOKING']} squad_name staging_number1 staging_number2 staging_number3</b>

    6. See staging book status (GROUP)
    <b>/status@#{ENV['BOT_BOOKING']} staging_number1 staging_number2 staging_number3</b>
    or
    <b>/status@#{ENV['BOT_BOOKING']} squad_name</b>

    7. See list of deploy branch request (GROUP)
    <b>/list_request@#{ENV['BOT_BOOKING']}</b>

    🐾 You can use another staging, not only DANA staging"
  end

  def help_jenkins
    "
    1. Deploy in specific staging (GROUP)
    <b>/deploy@#{ENV['BOT_JENKINS']} staging_number branch_name</b>

    2. Lock release in staging (GROUP)
    <b>/lock@#{ENV['BOT_JENKINS']} staging_number</b>

    3. Start BackBurner in staging (GROUP)
    <b>/start@#{ENV['BOT_JENKINS']} staging_number</b>

    4. Restart BackBurner in staging (GROUP)
    <b>/restart@#{ENV['BOT_JENKINS']} staging_number</b>

    5. Stop BackBurner in staging (GROUP)
    <b>/stop@#{ENV['BOT_JENKINS']} staging_number</b>

    6. Migrate database in staging (GROUP)
    <b>/migrate@#{ENV['BOT_JENKINS']} staging_number</b>

    7. Reindex data in staging (GROUP)
    <b>/reindex@#{ENV['BOT_JENKINS']} staging_number</b>

    8. Manual assets precompile (GROUP)
    <b>/precompile@#{ENV['BOT_JENKINS']} staging_number</b>

    9. Normalize staging date (GROUP)
    <b>/normalize@#{ENV['BOT_JENKINS']} staging_number</b>

    10. See list deployment (GROUP)
    <b>/deployment@#{ENV['BOT_JENKINS']}</b>

    🐾 You can use another staging, not only DANA staging"
  end

  def help_snack
    "
    When you try to add, edit or change snack schedule, please
    read carefully.

    - Day format
    only use <b>mon</b>, <b>tue</b>, <b>wed</b>, <b>thu</b> or <b>fri</b>

    1. Add people to snack schedule (GROUP)
    <b>/add@#{ENV['BOT_REMINDER']} day1 @username day2 @username</b>

    2. Change people schedule TEMPORARILY (GROUP)
    <b>/edit@#{ENV['BOT_REMINDER']} day1 @username day2 @username</b>

    3. Change snack schedule PERMANENTLY (GROUP)
    <b>/move@#{ENV['BOT_REMINDER']} day1 @username day2 @username</b>

    4. Delete people from schedule (GROUP)
    <b>/delete@#{ENV['BOT_REMINDER']} @username1 @username2 @username3</b>

    5. Cancel people from bring snack (GROUP)
    <b>/cancel@#{ENV['BOT_REMINDER']} @username1 @username2 @username3</b>

    6. People brought the snack (BOTH)
    <b>/done@#{ENV['BOT_REMINDER']} or /done@#{ENV['BOT_REMINDER']} @username</b>

    7. Free people from snack schedule (GROUP)
    <b>/holiday@#{ENV['BOT_REMINDER']} @all
    or
    /holiday@#{ENV['BOT_REMINDER']} @username1 @username2 @username3</b>

    8. Remind snack schedule (GROUP)
    <b>/reminder@#{ENV['BOT_REMINDER']}</b>

    9. Bring back normal schedule (GROUP)
    <b>/normal@#{ENV['BOT_REMINDER']}</b>

    10. List HI5 of Bandung squad member (BOTH)
    <b>/hi5@#{ENV['BOT_REMINDER']}</b>

    11. List vehicles of members (BOTH)
    <b>/plat@#{ENV['BOT_REMINDER']}</b>

    12. Add admin snack (PRIVATE)
    <b>/admin@#{ENV['BOT_REMINDER']} @username1 @username2 @username3</b>

    13. See the list of admin snack (GROUP)
    <b>/list_admin@#{ENV['BOT_REMINDER']}</b>

    14. Add new squad into Bandung (PRIVATE)
    <b>/squad@#{ENV['BOT_REMINDER']} squad_name1 squad_name2 squad_name3</b>

    15. See list of snack schedule (PRIVATE)
    <b>/schedule@#{ENV['BOT_REMINDER']}</b>

    <a href='https://bukalapak.atlassian.net/wiki/spaces/BS/pages/347046333/Snack+Schedule'>CHECK SCHEDULE</a>

    🐾 Only admin/PM/APM/EM/QAM can do add, edit, change,
    delete & holiday 😎"
  end

  def help_todo
    "
    1. Add squad to marketplace (GROUP)
    <b>/add_marketplace@#{ENV['BOT_TODO']} @username1 @username2 @username3</b>
    
    2. Displaying poin in inline keyboard (PRIVATE)
    <b>/keyboard@#{ENV['BOT_TODO']}</b>

    3. Displaying marketplace poin result (GROUP)
    <b>/show@#{ENV['BOT_TODO']}</b>

    🐾 Only admin, PM and APM can show the poin"
  end
end
