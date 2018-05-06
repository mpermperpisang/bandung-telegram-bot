# Untuk membaca text yang dikirimkan oleh user
class MessageText
  attr_reader :bot_name, :bot_troll, :booking_name, :stg, :req, :deploy, :bot_poin, :squad_name
  attr_reader :sprint, :space, :symbol, :command, :base_command
  #------------------------
  attr_reader :host, :host_remote, :username, :user, :password
  #------------------------
  attr_reader :squad, :admin, :pm, :dana_qa, :qa, :days

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
    @squad_name = txt[/\s[a-zA-Z][^\s]+/]
    @sprint = txt[/\s[a-zA-Z](.*)/]
    @space = txt[/\s[a-zA-Z0-9][^\s]+/]
    @symbol = txt[/\B@\S+/]
    @stg = txt[/\d+/] || false
  end

  def bot_command(txt)
    @command = txt[/\/[a-z]\S+/]
    @base_command = txt[/\/[a-z]\w+_/] || txt[/\/[a-z]\w+/]
  end

  def exc_text(txt)
    @req = txt[/^((?!request).)*$/]
    @deploy = txt[/^((?!deployment).)*$/]
  end

  def connection
    @host = 'localhost'
    @host_remote = '192.168.35.95'
    @username = 'root'
    @user = 'bukalapak'
    @password = 'bukalapak'
  end

  def bot_user
    @squad = %w[wtb bbm art core disco email]
    @admin = %w[mpermperpisang ak_fahmi tomifadlan teguhn duvadilon]
    @pm = %w[mpermperpisang ak_fahmi Maharaniar]
    @dana_qa = %w[mpermperpisang rezaldy08]
  end

  def quality_assurance
    @qa = %w[
      mpermperpisang amananm513 rezaldy08 damarananta chyntiacw rizkika andimryn WiraPramudy luthfiswees ihsanhsn
      nathanaelkrisna ariyohendrawan olvilora tinusagustin arsoedjono Fathirw ajengfujii irfanharies Mirzaaditya
      mukimahrizky ardhanapn fauridhomahran andiartop dickyedg ferie993 Yudhamau arisnugraha Fadhlimaulidri
      rizkyandika88 yudadul jassire marlilys ayynurp ananda8 izul683 tioagung annislatif devyebellika
      ferisaputra rizkibr Lamhotjm fitrirahmadhani palski tusiartihandayani petrisiamn prapto927 arifiandi
      ragapinilih agungenrico jeanclaudya fixcocandra lelimhr anisahnurh Yulinare irwinharnia Apreliamaisara
      syarifahzura reifa fitrilarasati trimamanurung
    ]
  end

  def weekdays
    @days = %w[mon tue wed thu fri]
  end
end
