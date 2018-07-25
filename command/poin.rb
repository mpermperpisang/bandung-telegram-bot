module Bot
  class Command
    # untuk memberikan poin ke task di marketplace
    class Poin < Command
      def check_text
        give_poin if @txt[0] != '/'
      end

      def give_poin
        value = ['0', '1/2', '1', '2', '3', '5', '8', '13', '20', '40', '100', 'kopi', 'unlimited']

        val_poin if value.include?(@txt)
      end

      def val_poin
        @bot.api.send_message(chat_id: @fromid, text: default_poin) if @txt == '0'
        input_poin if @txt != '0'
      end

      def input_poin
        @db = Connection.new

        check_poin = @db.check_poin_open(@username)
        check_poin.size.zero? ? member_not_exist : member_exist
      end

      def member_not_exist
        check_member = @db.check_member_market(@username)

        member = check_member.size.zero? ? not_member_market : next_chance
        @bot.api.send_message(chat_id: @fromid, text: member)
      end

      def member_exist
        @bot.api.send_message(chat_id: @fromid, text: accepted_poin)
        @db.update_market_closed(@txt, @username)
        @msgid = @db.show_message_id
        edit_msg unless @msgid.nil?
      end

      def edit_msg
        @result = @db.list_accepted_poin

        @array = []
        @result.each { |row| @array.push(row['member_market']) }

        @count = @result.count
        @poin_given = @array.to_s.gsub('", "', "\n").delete('["').delete('"]')

        @chat_id = @result.first['chat_id_market']

        begin
          p '+4'
          @bot.api.edit_message_text(chat_id: @chat_id, message_id: @msgid.first['message_id_market'].to_i + 4,
                                     text: done_poin(@count, @poin_given), parse_mode: 'HTML')
        rescue StandardError
          rescue_one
        end
      end

      def rescue_one
        p '+3'
        @bot.api.edit_message_text(chat_id: @chat_id, message_id: @msgid.first['message_id_market'].to_i + 3,
                                   text: done_poin(@count, @poin_given), parse_mode: 'HTML')
      rescue StandardError
        rescue_two
      end

      def rescue_two
        p '+2'
        @bot.api.edit_message_text(chat_id: @chat_id, message_id: @msgid.first['message_id_market'].to_i + 2,
                                   text: done_poin(@count, @poin_given), parse_mode: 'HTML')
      rescue StandardError
        last_rescue
      end

      def last_rescue
        p '+1'
        @bot.api.edit_message_text(chat_id: @chat_id, message_id: @msgid.first['message_id_market'].to_i + 1,
                                   text: done_poin(@count, @poin_given), parse_mode: 'HTML')
      rescue StandardError => e
        @bot.api.send_message(chat_id: ENV['ID_PRIVATE'], text: empty_edit(e))
      end
    end
  end
end
