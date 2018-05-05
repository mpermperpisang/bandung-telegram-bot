module Bot
  class Command
    # untuk melihat status staging
    class Status < Command
      def check_text
        status_staging if @txt.start_with?('/status')
      end

      def status_staging
        @db = Connection.new

        @db.status_staging

        @test = File.read('./require_ruby.rb')
        @test1 = @test.delete('"', '')
        @test2 = @test1.delete('}', '')
        @test3 = @test2.gsub("\n{book_status=>", '')
        @test4 = @test3.gsub('{book_branch=>', '')
        @test5 = @test4.gsub('{book_name=>', '')
        @test6 = @test5.gsub('booked', '<b>BOOKED</b>')
        @test7 = @test6.gsub('done', '<b>DONE</b>')

        @bot.api.send_message(chat_id: @chatid, text: @test7, parse_mode: 'HTML')
      end
    end
  end
end
