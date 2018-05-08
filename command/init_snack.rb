def snack_group(token, id, bot, msg, txt)
  Bot::Command::Add.new(token, id, bot, msg, txt).check_text
  Bot::Command::Edit.new(token, id, bot, msg, txt).check_text
  Bot::Command::Delete.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
end

def snack_private(token, id, bot, msg, txt)
  Bot::Command::WelcomeText.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
end
