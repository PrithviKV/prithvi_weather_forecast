require 'net/http'
require 'uri'

class WeatherService
    def self.call(latitude, longitude)

        #get forecast object from weather api
        uri = URI("https://api.weather.gov/points/#{latitude},#{longitude}")
        
        begin
            res = Net::HTTP.get_response(uri)
            body = JSON.parse(res.body)

            if body["properties"]
                forecast_uri = URI(body["properties"]["forecast"])

                #get weather forecast
                forecast_res = Net::HTTP.get_response(forecast_uri)
                forecast_body = JSON.parse(forecast_res.body)

                return forecast_body["properties"]["periods"] if forecast_body["properties"]["periods"]
            end
        rescue => e
            return e.message

        end
    end
end

