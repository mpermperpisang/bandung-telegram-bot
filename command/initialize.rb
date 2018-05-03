module Bot
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
    end
  end
end
