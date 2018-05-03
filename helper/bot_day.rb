class Day
  attr_reader :day_name
  attr_reader :hari
  attr_reader :snack

  def read_day(day)
    @day_name = case day
    when "mon"
      "Senin"
    when "tue"
      "Selasa"
    when "wed"
      "Rabu"
    when "thu"
      "Kamis"
    when "fri"
      "Jumat"
    else
      "Libur"
    end
  end

  def read_today
    @today = Date.today
    @day = @today.strftime("%a")
    @hari = @day.downcase

    @snack = case @day
    when "Mon"
      "Senin"
    when "Tue"
      "Selasa"
    when "Wed"
      "Rabu"
    when "Thu"
      "Kamis"
    when "Fri"
      "Jumat"
    else
      "Libur"
    end
  end
end
