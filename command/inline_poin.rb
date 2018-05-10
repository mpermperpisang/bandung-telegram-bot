module Bot
  class Command
    # untuk menampilkan poin dalam bentuk inline keyboard
    class InlinePoin < Command
      def check_text
        show_keyboard if @txt.start_with?('/keyboard')
        block_input if @txt.start_with?('0', '1/2', '1', '2', '3', '5', '8', '13', '20', '40', '100', 'kopi', 'unlimited')
      end

      def show_keyboard
        key_poin
        inline_keyboard
        @bot.api.send_message(chat_id: @fromid, text: choose_poin, reply_markup: @markup)
      end

      def block_input
        @bot.api.send_message(chat_id: @fromid, text: block_poin)
        show_keyboard
      end
    end
  end
end
