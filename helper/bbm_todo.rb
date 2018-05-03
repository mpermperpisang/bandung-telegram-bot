class BBMTodoList
  attr_reader :list_todo
  attr_reader :recall
  attr_reader :retro
  attr_reader :market
  attr_reader :poin_market
  attr_reader :message_from_id
  attr_reader :member_market
  attr_reader :msg_market
  attr_reader :list_poin
  attr_reader :chat_market

  @@booking = BBMBooking.new

  def to_do
    @@booking.line_read_booking

    line1 = @@booking.line.gsub('{"status"=>"', '')
    line2 = line1.gsub('"}', '')
    @list_todo = line2.gsub("\n", '')
  end

  def recall
    @@booking.line_read_booking

    list1 = @@booking.line.gsub('{"task"=>"','')
    list2 = list1.gsub('"}','')
    @recall = list2.gsub("\n",'')
  end

  def poin
    @@booking.line_read_booking

    list1 = @@booking.line.gsub('{"member_market"=>"@','')
    list2 = list1.gsub('", "poin_market"=>"',' ngasih poin = ')
    @poin_market = list2.gsub('"}','')
  end

  def list_member_market
    @@booking.line_read_booking

    list1 = @@booking.line.gsub('{"member_market"=>"','')
    list2 = list1.gsub('"}','')
    @member_market = list2.gsub("\n",'')
  end

  def list_member_poin
    @@booking.line_read_booking

    list1 = @@booking.line.gsub('{"member_market"=>"','')
    @list_poin = list1.gsub('"}','')
  end

  def retrospective
    @@booking.line_read_booking

    list1 = @@booking.line.gsub('{"list_retro"=>"','')
    @retro = list1.gsub('"}','')
  end

  def market_status
    @@booking.line_read_booking

    list1 = @@booking.line.gsub('{"status_market"=>"','')
    list2 = list1.gsub('"}','')
    @market = list2.gsub("\n",'')
  end

  def chat_id_private
    @@booking.line_read_booking

    name1 = @@booking.line.gsub('{"from_id_market"=>"', "")
    @message_from_id = name1.gsub('"}', "")

    File.open("./require_ruby.rb", "w+") do |f|
      f.puts(@message_from_id)
    end
  end

  def market_message_id
    @@booking.line_read_booking

    list1 = @@booking.line.gsub('{"message_id_market"=>"','')
    list2 = list1.gsub('"}','')
    @msg_market = list2.gsub("\n",'')
  end

  def id_chat_market
    @@booking.line_read_booking

    list1 = @@booking.line.gsub('{"chat_id_market"=>"','')
    list2 = list1.gsub('"}','')
    @chat_market = list2.gsub("\n",'')
  end
end
