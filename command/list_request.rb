module Bot
  class Command
    class ListRequest < Command
      def list_deploy_request
        list_request = Bot::DBConnect.new.list_request

        if list_request.empty?
          @bot.api.send_message(chat_id: @id, text: deployed(@message.from.username))
        else
          File.open("./require_ruby.rb", "w+") do |f|
            i = 1
            list_request.each do |row|
              f.puts("#{i}. Requester: " + row['deploy_request'] + ", branch: " + row['deploy_branch'])
              i = i + 1
            end
          end

          list_request = File.read('./require_ruby.rb')
          @bot.api.send_message(chat_id: @id, text: msg_list_request(list_request))
        end
      end
    end
  end
end
