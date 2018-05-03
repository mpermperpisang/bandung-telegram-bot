class BBMJenkins
  attr_reader :name
  attr_reader :status
  attr_reader :branch
  attr_reader :list_deploy
  attr_reader :message_chat_id

  @@booking = BBMBooking.new

  def gsub_deploy_request
    @@booking.line_read_booking

    name1 = @@booking.line.gsub('{"deploy_request"=>"', "")
    name2 = name1.gsub('"}', "")
    name3 = name2.gsub("\n", "")

    case name3
    when nil, ""
      @name = "None"
    else
      @name = "@"+name3
    end
  end

  def gsub_list_deploy
    @@booking.line_read_booking

    name = @@booking.line.gsub('{"deploy_date"=>', " ")
    name1 = name.gsub(' +0700, "deploy_branch"=>"', "\nBranch: ")
    name2 = name1.gsub('", "deploy_stg"=>"', " ke staging")
    name3 = name2.gsub('", "deployer"=>"', ".vm\nDeployer: ")
    @list_deploy = name3.gsub('"}', "")
  end

  def gsub_book_status
    @@booking.line_read_booking

    name1 = @@booking.line.gsub('{"book_status"=>"', "")
    name2 = name1.gsub('"}', "")
    @status = name2.gsub("\n", "")
  end

  def gsub_deploy_branch
    @@booking.line_read_booking

    name1 = @@booking.line.gsub('{"deploy_branch"=>"', "")
    name2 = name1.gsub('"}', "")
    @branch = name2.gsub("\n", "")
  end

  def chat_id_multigroup
    @@booking.line_read_booking

    name1 = @@booking.line.gsub('{"chat_id"=>"', "")
    @message_chat_id = name1.gsub('"}', "")

    File.open("./require_ruby.rb", "w+") do |f|
      f.puts(@message_chat_id)
    end
  end
end
