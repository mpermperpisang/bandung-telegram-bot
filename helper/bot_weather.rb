module Bot
  class TodayWeather
    attr_reader :poem
    attr_reader :main_weather
    attr_reader :weather

    def initialize
      opt = {
        units: 'metric', APPID: '4f01d46c448c55e948857830f8631e53'
      }

      opt[:lang] = 'id'
      cuaca = OpenWeather::Current.city('Bandung, ID', opt)
      if cuaca['weather'][0]['main'].nil? || cuaca['weather'][0]['main'] == ''
        @main_weather = 'error'
        @weather = '-'
        @poem = ', sayangnya lagi ngga ada ramalan cuaca untuk hari ini, Kak'
      else
        p @main_weather = cuaca['weather'][0]['main']
        p @weather = cuaca['weather'][0]['description']

        @poem = case @main_weather.downcase
                when 'rain'
                  ', jangan galau mikirin aku yaa'
                when 'clear'
                  ', semoga jiwa Kakak ngga sepi kaya lagu yaa'
                when 'clouds'
                  ', enaknya sekarang ngapain yaa, Kak?'
                when 'thunderstorm'
                  ', ga usah takut Kak, kan ada aku'
                when 'drizzle'
                  ', suasananya cocok buat istirahat yaa, Kak'
                when 'snow'
                  ', buat boneka salju yuk, Kak'
                when 'atmosphere'
                  ', semoga semakin semangat kerja yaa'
                when 'extreme'
                  ', hati-hati di jalan yaa, Kak'
                when 'additional'
                  ', indah yaa hari ini'
                end
      end
    end
  end
end
