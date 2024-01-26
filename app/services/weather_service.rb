require 'net/http'
require 'uri'

class WeatherService
    def self.call

        uri = URI('https://api.weather.gov/points/38.8894,-77.0352')


        res = Net::HTTP.get_response(uri)
        body = JSON.parse(res.body)
        forecast_uri = URI(body["properties"]["forecast"])


        forecast_res = Net::HTTP.get_response(forecast_uri)
        forecast_body = JSON.parse(forecast_res.body)
        forecast_body["properties"]["periods"]
        
    end
end