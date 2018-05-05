def todo_group(token, id, bot, msg, txt)
  Bot::Command::Show.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
end

def todo_private(token, id, bot, msg, txt)
  Bot::Command::Poin.new(token, id, bot, msg, txt).check_text
  Bot::Command::KeyboardPoin.new(token, id, bot, msg, txt).check_text
  Bot::Command::WelcomeText.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
end
