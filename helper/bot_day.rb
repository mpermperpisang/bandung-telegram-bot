# untuk menerjemahkan hari ke dalam bahasa Indonesia
class Day
  attr_reader :day_name
  attr_reader :hari
  attr_reader :snack

  def read_today
    @today = Date.today
    @day = @today.strftime('%a')
    @hari = @day.downcase
  end

  def read_day(day)
    @day_name = case day.strip
                when 'mon'
                  'Senin'
                when 'tue'
                  'Selasa'
                when 'wed'
                  'Rabu'
                when 'thu'
                  'Kamis'
                when 'fri'
                  'Jumat'
                else
                  'Libur'
                end
  end
end
