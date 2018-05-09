module Bot
  class Command
    # untuk menampilkan poin dalam bentuk inline keyboard
    class InlinePoin < Command
      def check_text
        show_keyboard if @txt.start_with?('/keyboard')
      end

      def show_keyboard
        key_poin
        inline_keyboard
        @bot.api.send_message(chat_id: @fromid, text: 'Pilih poin', reply_markup: @markup)
      end
    end
  end
end
