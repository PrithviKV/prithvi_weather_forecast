require 'net/http'
require 'uri'

class WeatherService
    def self.call(address)

        #get longitude and latitude from the address
        latitude, longitude = GeocodeService.new(address).get_coordinates

        
        #get forecast object from weather api
        uri = URI("https://api.weather.gov/points/#{latitude},#{longitude}")

        res = Net::HTTP.get_response(uri)
        body = JSON.parse(res.body)
        forecast_uri = URI(body["properties"]["forecast"])

        #get weather forecast
        forecast_res = Net::HTTP.get_response(forecast_uri)
        forecast_body = JSON.parse(forecast_res.body)
        forecast_body["properties"]["periods"]
        
    end
end