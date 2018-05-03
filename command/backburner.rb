require './is_true/staging.rb'
require './helper/backburner/bb_start.rb'
require './helper/backburner/bb_restart.rb'
require './helper/backburner/bb_stop.rb'

module Bot
  class Command
    class Backburner < Command
      @@staging = Staging.new
      @@start = Start.new
      @@stop = Stop.new
      @@restart = Restart.new

      def action(type)
        unless @@staging.is_empty?(@bot, @id, @message, @base_command, @staging)
          self.bb_action(type)
        end
      end

      def bb_action(type)
        if [*1..127].include?(@staging.to_i)
          staging = @staging
        else
          staging = "new"
        end

        if staging == "new"
          @bot.api.send_message(chat_id: @id, text: new_staging(@message.from.username, @staging), parse_mode: 'HTML')
        elsif type == "start"
          Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).queueing_request("start_#{staging}", staging, "backburner:start")
        elsif type == "restart"
          Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).queueing_request("restart_#{staging}", staging, "backburner:restart")
        elsif type == "stop"
          Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).queueing_request("stop_#{staging}", staging, "backburner:stop")
        end
      end

      def staging_backburner(type)
        if type == 'start'
          @bot.api.send_message(chat_id: @id, text: msg_backburner("start", @staging), parse_mode: 'HTML')
          @@start.perform(@bot, @id, @staging)
          @bot.api.send_message(chat_id: @id, text: msg_backburner_staging(@message.from.username, @staging, "started"), parse_mode: 'HTML')
        elsif type == 'stop'
          @bot.api.send_message(chat_id: @id, text: msg_backburner("stop", @staging), parse_mode: 'HTML')
          @@stop.perform(@bot, @id, @staging)
          @bot.api.send_message(chat_id: @id, text: msg_backburner_staging(@message.from.username, @staging, "stopped"), parse_mode: 'HTML')
        elsif type == 'restart'
          @bot.api.send_message(chat_id: @id, text: msg_backburner("restart", @staging), parse_mode: 'HTML')
          @@restart.perform(@bot, @id, @staging)
          @bot.api.send_message(chat_id: @id, text: msg_backburner_staging(@message.from.username, @staging, "restarted"), parse_mode: 'HTML')
        end
      end
    end
  end
end
