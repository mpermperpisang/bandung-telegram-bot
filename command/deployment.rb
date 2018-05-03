module Bot
  class Command
    # daftar deployment branch ke staging
    class Deployment < Command
      def deployment_staging
        @db = Connection.new
        @send = SendMessage.new

        @deploy = @db.list_deployment

        @send.empty_deploy(@id, @username)
        @deploy.size.zero? ? @bot.api.send_message(@send.message) : list_stg_deploy
      end

      def list_stg_deploy
        File.open('./require_ruby.rb', 'w+') do |f|
          i = 1
          @deploy.each do |row|
            longtime = (DateTime.now - (row['deploy_date']).to_datetime)
            hours = ((longtime * 24 * 60) / 60).to_i
            min = (longtime * 24 * 60).to_i

            minutes = min < 60 ? min : min - (60 * hours)

            @db.deploy_duration("#{hours} hours and #{minutes} minutes", row['deploy_branch'])

            f.puts("#{i}. #{row['deploy_date'].to_s.gsub(' +0700', '')}\nDuration: #{hours} hours and #{minutes} minutes
Branch: <b>#{row['deploy_branch']} </b>Staging: <code>staging#{row['deploy_stg']}.vm</code>
Deployer: @#{row['deployer']}\n\n")
            i += 1
          end
        end
        read_deployment
      end

      def read_deployment
        list_deploy = File.read('./require_ruby.rb')
        @bot.api.send_message(chat_id: @id, text: list_deployment(list_deploy, @username), parse_mode: 'HTML')
      end
    end
  end
end
