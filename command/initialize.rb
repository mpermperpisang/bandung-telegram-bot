module Bot
<<<<<<< HEAD
  # inisialisasi variable
  class Command
    def initialize(token, id, bot, message, txt)
      @msg = MessageText.new

      @msg.read_text(txt)
      comm_var

      @token = token
      @id = id
      @bot = bot
      @message = message
      @txt = txt
      @username = @message.from.username
      @chatid = @message.chat.id
      @fromid = @message.from.id
    end

    def comm_var
      @space = @msg.space
      @symbol = @msg.symbol
      @command = @msg.command
      @staging = @msg.stg
      @base_command = @msg.base_command
      @sprint = @msg.sprint
=======
  class Command
    @@msg = MessageText.new

    def initialize(token, chat_id, bot, message, command)
      @@msg.read_text(command)

      @token = token
      @id = chat_id
      @bot = bot
      @message = message
      @txt = command
      @space = @@msg.space
      @symbol = @@msg.symbol
      @command = @@msg.command
      @staging = @@msg.staging
      @base_command = @@msg.base_command
      @sprint = @@msg.sprint
>>>>>>> f283ac5038ede1fcad4cc2453ee61073fbc54e0e
    end
  end
end
