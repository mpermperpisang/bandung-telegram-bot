require './helper/bot_detail.rb'

<<<<<<< HEAD
# Untuk memeriksa status bot, online atau offline
=======
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
class BotStatus
  include BotDetail

  attr_accessor :type_status, :token

  def conn_status(addition)
    "#{fullname} : <code>#{connection}</code>\n\nJangan lupa semangat yaa, Kak.\n#{addition}"
  end
end
