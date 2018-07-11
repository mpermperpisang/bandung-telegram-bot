def key_poin
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
      Telegram::Bot::Types::InlineKeyboardButton.new(text: '∞', callback_data: 'unlimited')
    ]
  ]
end

def key_day
  @kb = [
    [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Senin', callback_data: 'mon'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Selasa', callback_data: 'tue'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Rabu', callback_data: 'wed')
    ],
    [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Kamis', callback_data: 'thu'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Jumat', callback_data: 'fri')
    ]
  ]
end

def key_squad
  @kb = [
    [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'WTB', callback_data: 'wtb'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'DANA', callback_data: 'dana')
    ],
    [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'ART', callback_data: 'art'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'DISCO', callback_data: 'disco')
    ],
    [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Core', callback_data: 'core'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bandung [Post to Teletubis]', callback_data: 'bandung')
    ]
  ]
end

def inline_keyboard
  @markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @kb)
end
