<<<<<<< HEAD
require './message/message_text.rb'
# Untuk membedakan berbagai jenis pengguna bot
class User
  attr_reader :spam

  def developer?(bot, id, user)
    qa = @msg.dana_qa
    bot.api.send_message(chat_id: id, text: errorDev(user)) if qa.include?(user)
  end

  def quality_assurance?(bot, id, user, txt)
    @msg = MessageText.new
    @msg.read_text(txt)
    @msg.quality_assurance

    qa = @msg.qa
    bot.api.send_message(chat_id: id, text: errorQA(user)) unless qa.include?(user)
  end

  def admin?(bot, id, user)
    admin = @msg.admin
    bot.api.send_message(chat_id: id, text: errorAdmin(user)) unless admin.include?(user)
  end

  def pm?(bot, id, user)
    pm = @msg.pm
    bot.api.send_message(chat_id: id, text: errorPM(user)) unless pm.include?(user)
  end

  def spammer?(bot, id, user, message, data)
    admin = @msg.admin
    squad = @msg.squad
    grup_id = squad.include?(data) ? message.from.id : id

    check_spammer(admin, bot, user, data, grup_id)
=======
class User
  attr_reader :spam

  @@reminder = BandungSnack.new

  def is_developer?(bot, id, user)
    if user == "mpermperpisang" || user == "amananm513" || user == "rezaldy08"
      bot.api.send_message(chat_id: id, text: errorDev(user))
    end
  end

  def is_quality_assurance?(bot, id, user)
    qa = ["mpermperpisang", "amananm513", "rezaldy08", "damarananta", "chyntiacw", "rizkika",
        "andimryn", "WiraPramudy", "luthfiswees", "ihsanhsn", "nathanaelkrisna", "ariyohendrawan",
        "olvilora", "tinusagustin", "arsoedjono", "Fathirw", "ajengfujii", "irfanharies", "Mirzaaditya",
        "mukimahrizky", "ardhanapn", "fauridhomahran", "andiartop", "dickyedg", "ferie993", "Yudhamau",
        "arisnugraha", "Fadhlimaulidri", "rizkyandika88", "yudadul", "jassire", "marlilys", "ayynurp",
        "ananda8", "izul683", "tioagung", "annislatif", "devyebellika", "ferisaputra", "rizkibr", "Lamhotjm",
        "fitrirahmadhani", "palski", "tusiartihandayani", "petrisiamn", "prapto927", "arifiandi", "ragapinilih",
        "agungenrico", "jeanclaudya", "fixcocandra", "lelimhr", "anisahnurh", "Yulinare", "irwinharnia", "Apreliamaisara",
        "syarifahzura", "reifa", "fitrilarasati", "trimamanurung"]

    unless qa.include?(user)
      bot.api.send_message(chat_id: id, text: errorQA(user))
    end
  end

  def is_admin?(bot, id, user)
    unless user == "mpermperpisang" || user == "ak_fahmi" || user == "tomifadlan" || user == "teguhn" || user == "duvadilon"
      bot.api.send_message(chat_id: id, text: errorAdmin(user))
    end
  end

  def is_pm?(bot, id, user)
    unless user == "mpermperpisang" || user == "ak_fahmi" || user == "Maharaniar"
      bot.api.send_message(chat_id: id, text: errorPM(user))
    end
  end

  def is_spammer?(bot, id, user, message, data)
    squad = ["wtb", "bbm", "art", "core", "disco", "email"]

    check_spammer(user, data)
    @@reminder.gsub_bot_attempt
    @attempt = @@reminder.att

    if user == "mpermperpisang" || user == "ak_fahmi" || user == "tomifadlan" || user == "teguhn" || user == "duvadilon"
      count = 10
    else
      count = 1
    end

    if ((@attempt.to_i>=0 && @attempt.to_i<count) || @attempt=="" || @attempt==nil)
      @spam = false
    elsif @attempt.to_i==count+1
      @spam = true

      unless squad.include?(data)
        bot.api.send_message(chat_id: id, text: errorSpam(user))
      else
        bot.api.send_message(chat_id: message.from.id, text: errorSpam(user))
      end
    end

    save_spammer(user, data)
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
  end
end
