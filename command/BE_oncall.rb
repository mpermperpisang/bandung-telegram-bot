module Bot
  class Command
    # untuk menambahkan orang ke jadwal snack
    class BEOnCall < Command
      def check_text
        call_be if @txt.start_with?('/oncall', '/oncall@book_stg_bot')
      end

      def call_be
        service = Google::Apis::SheetsV4::SheetsService.new
        service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: File.open('client_secret.json'),
          scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY)
        
        # Query the spreadsheet
        spreadsheet_id = '1LNoA8XX-motCQW1rCmCQ5wyuwQJfOvb0NPUJMZa243I'
        
        @today = Date.today
        @day = @today.strftime("%a")
        @date = @today.strftime("%d")
        @month = @today.strftime("%m")
        @year = @today.strftime("%Y")

        @sheet = case @month
        when '01'
          'B'
        when '02'
          'C'
        when '03'
          'D'
        when '04'
          'E'
        when '05'
          'F'
        when '06'
          'G'
        when '07'
          'H'
        when '08'
          'I'
        when '09'
          'J'
        when '10'
          'K'
        when '11'
          'L'
        when '12'
          'M'
        end
        
        range = "Oncall!#{@sheet}#{@date.to_i + 1}"
        
        response = service.get_spreadsheet_values(spreadsheet_id, range)
        @be = response.values.to_s.gsub('", "', ",\n- ").delete('["').delete('"]')
        if @be != '' && (@day == 'Mon' || @day == 'Tue' || @day == 'Wed' || @day == 'Thu' || @day == 'Fri')
          @bot.api.send_message(chat_id: @message.chat.id, text: be_oncall(@username, @be), parse_mode: 'HTML')
        elsif (@be.nil? || @be == '') && (@day != 'Sat' || @day != 'Sun')
          @bot.api.send_message(chat_id: @message.chat.id, text: empty_oncall(@username), parse_mode: 'HTML')
        elsif @day == 'Sat' || @day == 'Sun'
          @bot.api.send_message(chat_id: @message.chat.id, text: no_oncall(@username), parse_mode: 'HTML')
        end
      end
    end
  end
end
