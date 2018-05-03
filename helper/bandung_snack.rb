class BandungSnack
  attr_reader :n
  attr_reader :day
  attr_reader :day_n
  attr_reader :status
  attr_reader :cuaca
  attr_reader :att
  attr_reader :name
  attr_reader :hi5_email

  @@booking = BBMBooking.new

  def gsub_name
    @@booking.line_read_booking

    line = @@booking.line.gsub('{"name"=>"', '')
    @name = line.gsub('"}', '')
  end

  def gsub_squad_hi5
    @@booking.line_read_booking

    line = @@booking.line.gsub('{"hi_name"=>"', '')
    name1 = line.gsub('"}', '')
    @name = name1.gsub("\n", ' ')
  end

  def gsub_day
    @@booking.line_read_booking

    line = @@booking.line.gsub('{"day"=>"', '')
    n = line.gsub('"}', '')
    @day = n[0..2]
  end

  def gsub_status
    @@booking.line_read_booking

    line = @@booking.line.gsub('{"status"=>"', '')
    n = line.gsub('"}', '')
    @status = n.gsub("\n", '')
  end

  def gsub_day_n
    @@booking.line_read_booking

    day1 = @@booking.line.gsub('{"day"=>"', '')
    day2 = day1.gsub('"}', '')
    @day_n = day2.gsub("\n", '')
  end

  def gsub_bot_attempt
    @@booking.line_read_booking

    att1 = @@booking.line.gsub('{"bot_attempt"=>', "")
    att2 = att1.gsub('}', "")
    @att = att2.gsub("\n", "")
  end

  def gsub_bandung_hi5
    @@booking.line_read_booking

    name1 = @@booking.line.gsub('hi_name', '')
    name2 = name1.gsub('{""=>"', '')
    name3 = name2.gsub('"}', '')
    name4 = name3.gsub("\n", ' ')
    name5 = name4.gsub("ART ", "ART\n")
    name6 = name5.gsub("BBM ", "\n\nBBM\n")
    name7 = name6.gsub("WTB ", "\n\nWTB\n")
    name8 = name7.gsub("CORE ", "\n\nCORE\n")
    name9 = name8.gsub("DISCO ", "\n\DISCO\n")
    @name = name9.gsub("BANDUNG a.k.a belum ada squad ", "\n\nBANDUNG a.k.a belum masuk squad\n")
  end

  def gsub_bandung_email
    @@booking.line_read_booking

    att1 = @@booking.line.gsub('{"hi_email"=>"', "")
    @hi5_email = att1.gsub('"}', "")
  end

  def gsub_duplicate_hi5
    @@booking.line_read_booking

    name1 = @@booking.line.gsub('{"name"=>', "")
    @name = name1.gsub('"}', '')
  end
end
