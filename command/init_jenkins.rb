def jenkins_group(token, id, bot, msg, txt)
  Bot::Command::DeployStaging.new(token, id, bot, msg, txt).check_text
  Bot::Command::Deployment.new(token, id, bot, msg, txt).check_text
end

def jenkins_private(token, id, bot, msg, txt)
  Bot::Command::WelcomeText.new(token, id, bot, msg, txt).bot_start
end
