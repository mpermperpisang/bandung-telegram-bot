module Bot
  class Command
    # untuk menampilkan poin dalam bentuk inline keyboard
    class KeyboardPoin < Command
      def check_text
        show_keyboard if @txt.start_with?('/keyboard')
      end

      def show_keyboard
        @kb = [
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '1/2', callback_data: '1/2'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '1', callback_data: '1'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '2', callback_data: '2')
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '3', callback_data: '3'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '5', callback_data: '5'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '8', callback_data: '8')
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '13', callback_data: '13'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '20', callback_data: '20'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '40', callback_data: '40')
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '100', callback_data: '100'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '☕️', callback_data: 'kopi'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: '〰', callback_data: 'unlimited')
          ]
        ]
        inline_keyboard
      end

      def inline_keyboard
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @kb)
        @bot.api.send_message(chat_id: @fromid, text: 'Pilih poin', reply_markup: markup)
      end
    end
  end
end
