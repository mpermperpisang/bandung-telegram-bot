def check_spammer(user, command)
  @db = Connection.new

  @db.checking_spam(user, command)
end

def save_spammer(user, command)
  @db = Connection.new

  @db.saving_spam(user, command)
end
