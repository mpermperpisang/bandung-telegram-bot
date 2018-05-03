class MessageText
  attr_reader :bot_name
  attr_reader :bot_troll
  attr_reader :booking_name
  attr_reader :staging
  attr_reader :request
  attr_reader :deployment
  attr_reader :bot_poin
  attr_reader :squad_name
  attr_reader :sprint
  attr_reader :space
  attr_reader :symbol
  attr_reader :command
  attr_reader :base_command
  #------------------------
  attr_reader :host
  attr_reader :host_remote
  attr_reader :username
  attr_reader :user
  attr_reader :password

  def read_text(txt)
    @bot_name = txt[/\/[a-z]\w+/]
    @bot_troll = txt[/^[a-zA-Z?_\-]+$/]
    @booking_name = txt[/\/[a-z]*_{0}/]
    @staging = txt[/\d+/] || false
    @request = txt[/^((?!request).)*$/]
    @deployment = txt[/^((?!deployment).)*$/]
    @bot_poin = txt[/[a-z0-9]+/]
    @squad_name = txt[/\s[a-zA-Z][^\s]+/]
    @sprint = txt[/\s[a-zA-Z](.*)/]
    @space = txt[/\s[a-zA-Z0-9][^\s]+/]
    @symbol = txt[/\B@\S+/]
    @command = txt[/\/[a-z]\S+/]
    @base_command = txt[/\/[a-z]\w+_/] || @bot_name
  end

  def connection
    @host = "localhost"
    @host_remote = "192.168.35.95"
    @username = "root"
    @user = "bukalapak"
    @password = "bukalapak"
  end
end
