class Name
  attr_reader :bot_name

  def is_bot_include?(name)
    unless name == "@#{ENV['BOT_BOOKING']}" || name == "@#{ENV['BOT_JENKINS']}" || name == "@#{ENV['BOT_JENKINS_2']}" || name == "@#{ENV['BOT_JENKINS_3']}" || name == "@#{ENV['BOT_REMINDER']}" || name == "@#{ENV['BOT_TODO']}"
      @bot_name = false
    else
      @bot_name = true
    end
  end
end
