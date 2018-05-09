def snack_group(token, id, bot, msg, txt)
  Bot::Command::Add.new(token, id, bot, msg, txt).check_text
  Bot::Command::Edit.new(token, id, bot, msg, txt).check_text
  Bot::Command::Delete.new(token, id, bot, msg, txt).check_text
  Bot::Command::DoneSnack.new(token, id, bot, msg, txt).check_text
  Bot::Command::Reminder.new(token, id, bot, msg, txt).check_text
  Bot::Command::CancelSnack.new(token, id, bot, msg, txt).check_text
  Bot::Command::Holiday.new(token, id, bot, msg, txt).check_text
  Bot::Command::Normal.new(token, id, bot, msg, txt).check_text
  Bot::Command::Change.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
end

def snack_private(token, id, bot, msg, txt)
  Bot::Command::WelcomeText.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
end
