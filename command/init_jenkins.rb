def jenkins_group(token, id, bot, msg, txt)
  Bot::Command::DeployStaging.new(token, id, bot, msg, txt).check_text
end

def jenkins_private
  p 'private'
end
