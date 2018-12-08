module Bot
  class Command
    # untuk mengingatkan jadwal snack kalau cronjobnya bermasalah
    class SnackSchedule < Command
      def check_text
        check_schedule if @txt.start_with?('/schedule')
      end

      def remind_schedule
        key_day
        inline_keyboard
        @bot.api.send_message(chat_id: @message.from.id, text: see_schedule, reply_markup: @markup)
      end
    end
  end
end
