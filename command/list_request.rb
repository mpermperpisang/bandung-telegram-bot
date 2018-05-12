module Bot
  class Command
    # untuk melihat daftar permintaan deploy branch ke staging
    class ListRequest < Command
      def check_text
        list_deploy_request if @txt.start_with?('/list_request')
      end

      def list_deploy_request
        @db = Connection.new

        @list_deploy = @db.list_request

        @list_deploy.size.zero? ? @bot.api.send_message(chat_id: @chatid, text: deployed) : listing_request
      end

      def listing_request
        @array = []
        i = 1
        @list_deploy.each do |row|
          @array.push("#{i}. Requester: <code>@" + row['deploy_request'] + "</code>\n\n<b>" +
                      row['deploy_branch'] + "</b>\n\n")
          i += 1
        end

        @list_req = @array.to_s.delete('["').delete('"]').gsub('\n\n', "\n").gsub('\n', '').gsub(', ', '')
        @bot.api.send_message(chat_id: @chatid, text: msg_list_request(@list_req), parse_mode: 'HTML')
      end
    end
  end
end
