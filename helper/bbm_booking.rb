class BBMBooking
  attr_reader :line
  attr_reader :name
  attr_reader :status
  attr_reader :name_book
  attr_reader :name_done
  attr_reader :book_name
  attr_reader :book_from_id
  attr_reader :cek_status

  def line_read_booking
    @line = File.read('./require_ruby.rb')
  end

  def gsub_deploy_request_branch
    self.line_read_booking

    name1 = self.line.gsub('{"deploy_request"=>"', '')
    name2 = name1.gsub('", "deploy_branch"=>"', ', branch : ')
    @name = name2.gsub('"}', "")
  end

  def gsub_deploy_branch
    self.line_read_booking

    name1 = self.line.gsub('{"deploy_branch"=>"', '')
    name2 = name1.gsub("\n", "")
    @name = name2.gsub('"}', "")
  end

  def gsub_book_status_name
    self.line_read_booking

    @status = self.line[17..20]
    name1 = self.line.gsub('{"book_status"=>"done", "book_name"=>"','')
    name2 = name1.gsub('{"book_status"=>"booked", "book_name"=>"', '')
    name_book1 = name2.gsub('"}', '')
    @name_book = name_book1.gsub("\n", '')
    name_done1 = name1.gsub('"}', '')
    @name_done = name_done1.gsub("\n", '')
  end

  def gsub_book_name
    self.line_read_booking

    name1 = self.line.gsub('{"book_name"=>"', '')
    name2 = name1.gsub('"}', '')
    @book_name = name2.gsub("\n", '')
  end

  def gsub_book_id
    self.line_read_booking

    name1 = self.line.gsub('{"book_from_id"=>"', '')
    name2 = name1.gsub('"}', '')
    @book_from_id = name2.gsub("\n", '')
  end

  def gsub_staging_status
    self.line_read_booking

    cek_status1 = self.line.gsub("\n",'')
    cek_status2 = cek_status1.gsub('"}', "\n")
    cek_status3 = cek_status2.gsub('{"book_status"=>"', '')
    cek_status4 = cek_status3.gsub('{"book_branch"=>"', '')
    cek_status5 = cek_status4.gsub('{"book_name"=>"', '')
    cek_status6 = cek_status5.gsub('staging51', "\n<code>staging51</code>")
    cek_status7 = cek_status6.gsub('staging103', "\n<code>staging103</code>")
    cek_status8 = cek_status7.gsub('done', "<b>DONE</b>")
    cek_status9 = cek_status8.gsub('booked', "<b>BOOKED</b>")
    cek_status10 = cek_status9.gsub('PIC', "\nPIC")
    @cek_status = cek_status10.gsub('staging21', "\n<code>staging21</code>")
  end
end
