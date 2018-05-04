def booking_group(token, id, bot, msg, txt)
  Bot::Command::Booking.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
end

def booking_private(token, id, bot, msg, txt)
  Bot::Command::WelcomeText.new(token, id, bot, msg, txt).check_text
  Bot::Command::Help.new(token, id, bot, msg, txt).check_text
end
