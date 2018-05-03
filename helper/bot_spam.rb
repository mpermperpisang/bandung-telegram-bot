def check_spammer(user, command)
  Bot::DBConnect.new.check_spam(user, command)
end

def save_spammer(user, command)
  Bot::DBConnect.new.save_spam(user, command)
end
