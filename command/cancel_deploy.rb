module Bot
  class Command
    # untuk membatalkan permintaan deploy branch ke staging
    class CancelDeploy < Command
      def check_text
        check_branch_empty if @txt.start_with?('/cancel_request')
      end

      def check_branch_empty
        @is_branch = Branch.new

        deploy_cancel unless @is_branch.empty?(@bot, @chatid, @space, @txt, @username)
      end

      def deploy_cancel
        @db = Connection.new

        cancel = @db.check_deploy_req(@space)

        if cancel.nil? || cancel.size.zero?
          @bot.api.send_message(chat_id: @chatid, text: cancel_empty(@username, @space), parse_mode: 'HTML')
        else
          @db.cancel_deploy(@space)
          @bot.api.send_message(chat_id: @chatid, text: msg_cancel_deploy(@space), parse_mode: 'HTML')
        end
      end
    end
  end
end
