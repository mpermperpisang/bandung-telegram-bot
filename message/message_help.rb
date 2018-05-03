require './helper/bot_detail.rb'

class HelpMessage
  include BotDetail

  attr_accessor :name, :message

  def help_group(user)
    "Dear @#{user}, kalau mau bantuan aku, japri ajah deh (@#{username})\n☺️"
  end

  def help_private(user)
    "Yohoo @#{user}. Please read and remember.\n#{help}

👣 group means you can only send these commands in your Telegram group
👣 private means you can only send these commands if you chat with me
👣 both means you can send these commands either in group or private chat with me

    #want to help improve this bot? message @mpermperpisang, okay?! 😘"
  end
end
