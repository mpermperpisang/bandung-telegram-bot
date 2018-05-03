module Bot
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
    end
  end
end
