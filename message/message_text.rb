# Untuk membaca text yang dikirimkan oleh user
class MessageText
  attr_reader :bot_name, :bot_troll, :booking_name, :stg, :req, :deploy, :bot_poin, :squad_name
  attr_reader :sprint, :space, :symbol, :command, :base_command, :vehicle_no, :owner, :type, :plat
  #------------------------
  attr_reader :host, :host_remote, :username, :user, :password
  #------------------------
  attr_reader :squad, :admin, :pm, :qa, :days

  def read_text(txt)
    @bot_name = txt[/\/[a-z]\w+/]
    @bot_troll = txt[/^[a-zA-Z?_\-]+$/]
    @bot_poin = txt[/[a-z0-9]+/]
    bot_attr(txt)
    bot_command(txt)
    exc_text(txt)
  end

  def bot_attr(txt)
    @booking_name = txt[/\/[a-z]*_{0}/]
    @squad_name = txt[/\s[a-zA-Z_ ]+/]
    @sprint = txt[/\s[a-zA-Z](.*)/]
    @space = txt[/\s[a-zA-Z0-9]{0}[a-zA-Z][^\s]+/]
    @symbol = txt[/\B@\S+/]
    @stg = txt[/\s\d+/] || false
    @vehicle_no = txt[/[a-zA-Z]{1,}\s[0-9]*\s[a-zA-Z]+/]
    @owner = txt[/\B@\S+/]
    @type = txt[/[mobil|motor]{5}/]
    @plat = txt[/[a-zA-Z]{1,}\s[0-9]*\s[a-zA-Z]+/]
  end

  def bot_command(txt)
    @command = txt[/\/[a-z]\S+/]
    @base_command = txt[/\/[a-z]\w+/]
  end

  def exc_text(txt)
    @req = txt[/^((?!request).)*$/]
    @deploy = txt[/^((?!deployment).)*$/]
  end

  def connection
    @host = 'localhost'
    @host_remote = ENV['HOST_REMOTE']
    @username = ENV['USERNAME']
    @user = ENV['USER']
    @password = ENV['PASSWORD']
  end

  def bot_user
    @db = Connection.new

    @admin = []

    @admin_check = @db.list_admin
    @admin_check.each do |name|
      @admin.push(name['adm_username'])
    end

    @pm = %w[mpermperpisang ak_fahmi Maharaniar ditra7 Fadhlimaulidri]
  end

  def quality_assurance
    @qa = %w[
      mpermperpisang amananm513 rezaldy08 ihsanhsn denishendriansah
    ]
  end

  def bot_squad
    @db = Connection.new

    @squad = []

    @squad_check = @db.list_squad
    @squad_check.each do |squad|
      @squad.push(squad['squad_name'])
    end
  end

  def weekdays
    @days = %w[mon tue wed thu fri]
  end
end
