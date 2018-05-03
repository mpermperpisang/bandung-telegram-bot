require './is_true/staging.rb'
require './helper/rake/rake_migrate.rb'
require './helper/rake/rake_precompile.rb'
require './helper/rake/rake_reindex.rb'

module Bot
  class Command
    class Rake < Command
      @@staging = Staging.new
      @@migrate = Migrate.new
      @@reindex = Reindex.new
      @@precompile = Precompile.new

      def action(type)
        unless @@staging.is_empty?(@bot, @id, @message, @base_command, @staging)
          self.rake_action(type)
        end
      end

      def rake_action(type)
        if [*1..127].include?(@staging.to_i)
          staging = @staging
        else
          staging = "new"
        end

        if staging == "new"
          @bot.api.send_message(chat_id: @id, text: new_staging(@message.from.username, @staging), parse_mode: 'HTML')
        elsif type == "migrate"
          Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).queueing_request("migrate_#{staging}", staging, "db:migrate")
        elsif type == "reindex"
          Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).queueing_request("reindex_#{staging}", staging, "elasticsearch:reindex_index")
        elsif type == "precompile"
          Bot::Command::DeployStaging.new(@token, @id, @bot, @message, @txt).queueing_request("precompile_#{staging}", staging, "assets:precompile")
        end
      end

      def staging_rake(type)
        if type == 'migrate'
          @bot.api.send_message(chat_id: @id, text: msg_rake("Database migrate", @staging), parse_mode: 'HTML')
          @@migrate.perform(@bot, @id, @staging)
          @bot.api.send_message(chat_id: @id, text: msg_rake_staging(@message.from.username, @staging, "migrated"), parse_mode: 'HTML')
        elsif type == 'reindex'
          @bot.api.send_message(chat_id: @id, text: msg_rake("Reindex", @staging), parse_mode: 'HTML')
          @@reindex.perform(@bot, @id, @staging)
          @bot.api.send_message(chat_id: @id, text: msg_rake_staging(@message.from.username, @staging, "reindexed"), parse_mode: 'HTML')
        elsif type == 'precompile'
          @bot.api.send_message(chat_id: @id, text: msg_rake("Assets Precompile", @staging), parse_mode: 'HTML')
          @@precompile.perform(@bot, @id, @staging)
          @bot.api.send_message(chat_id: @id, text: msg_rake_staging(@message.from.username, @staging, "precompiled"), parse_mode: 'HTML')
        end
      end
    end
  end
end
