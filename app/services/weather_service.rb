require 'net/http'
require 'uri'

# WeatherService obtains the forecast for a (lat, long) US location
# We use the free NWS REST API documented here: https://weather-gov.github.io/api/general-faqs

class WeatherService
    def self.call(latitude, longitude)

        #get forecast object from weather api
        uri = URI("https://api.weather.gov/points/#{latitude},#{longitude}")
        
        begin
            #get JSON response
            res = Net::HTTP.get_response(uri)
            body = JSON.parse(res.body)

            if body["properties"]
                #get forecast REST API URL
                forecast_uri = URI(body["properties"]["forecast"])

                #get weather forecast JSON response
                forecast_res = Net::HTTP.get_response(forecast_uri)
                forecast_body = JSON.parse(forecast_res.body)

                #extract weather values for each time period
                return forecast_body["properties"]["periods"] if forecast_body["properties"]["periods"]
            end
        rescue => e
            return e.message
        end
    end
end

