module Bot
  class Command
    class Deployment < Command
      @@jenkins = BBMJenkins.new

      def deployment_staging
        deploy = Bot::DBConnect.new.list_deployment

        unless deploy.empty?
          File.open("./require_ruby.rb", "w+") do |f|
            i = 1
            deploy.each do |row|
              longtime = (DateTime.now - (row['deploy_date']).to_datetime)
              hours = ((longtime * 24 * 60) / 60).to_i
              min = ((longtime * 24 * 60).to_i)

              if min < 60
                minutes = min
              else min > 60
                minutes = min - (60 * hours)
              end

              Bot::DBConnect.new.deploy_duration("#{hours} hours and #{minutes} minutes", row['deploy_branch'])
              
              f.puts("#{i}. #{(row['deploy_date'].to_s).gsub(' +0700', '')}\nDuration: #{hours} hours and #{minutes} minutes\nBranch: <b>" + row['deploy_branch'] + "</b>\nStaging: <code>staging" + row['deploy_stg'] + ".vm</code>\nDeployer: @" + row['deployer'] + "\n\n")
              i = i + 1
            end
          end

          list_deploy = File.read('./require_ruby.rb')
          @bot.api.send_message(chat_id: @id, text: list_deployment(list_deploy, @message.from.username), parse_mode: 'HTML')
        else
          @bot.api.send_message(chat_id: @id, text: empty_deployment(@message.from.username))
        end
      end
    end
  end
end
