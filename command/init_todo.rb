def todo_group(token, id, bot, msg, txt)
  Bot::Command::Show.new(token, id, bot, msg, txt).check_text
  Bot::Command::AddMarketplace.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
end

def todo_private(token, id, bot, msg, txt)
  Bot::Command::WelcomeText.new(token, id, bot, msg, txt).check_text
  Bot::Command::Market.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
  Bot::Command::InlinePoin.new(token, id, bot, msg, txt).check_text
end
