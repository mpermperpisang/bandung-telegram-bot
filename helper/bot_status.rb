require './helper/bot_detail.rb'

# Untuk memeriksa status bot, online atau offline
class BotStatus
  include BotDetail

  attr_accessor :type_status, :token

  def conn_status(addition)
    "#{fullname} : <code>#{connection}</code>\n\nJangan lupa semangat yaa, Kak.\n#{addition}"
  end
end
