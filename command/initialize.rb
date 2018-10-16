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
      @firstname = @message.from.first_name
      @fromid = @message.from.id
      @chatid = @message.chat.id
    rescue StandardError
      @chatid = false
    end

    def comm_var
      @space = @msg.space
      @symbol = @msg.symbol
      @command = @msg.command
      if @msg.stg.nil? || @msg.stg == false
        @staging = @msg.stg
      else
        @staging = @msg.stg.strip
      end
      @base_command = @msg.base_command
      @sprint = @msg.sprint
      @vehicle_number = @msg.vehicle_no
      @squad_name = @msg.squad_name
      @ve_owner = @msg.owner
      @ve_type = @msg.type
      @ve_plat = @msg.plat
    end
  end
end
