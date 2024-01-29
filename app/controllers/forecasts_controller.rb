class ForecastsController < ApplicationController
    def index

        @address = params[:address]
        
        #check address is present and it is in the right format
        if @address && is_correct_format?
            begin
                
                @geocode = GeocodeService.new(@address)

                # zipcode as weather_cache_key
                @weather_cache_key = @geocode.get_address_hash["zipcode"]

                @weather_cache_exist = Rails.cache.exist?(@weather_cache_key)

                @data = Rails.cache.fetch(@weather_cache_key, expires_in: 30.minutes) do

                    #get longitude and latitude from the address
                    latitude, longitude = @geocode.get_coordinates

                    #get forecast data from Api
                    WeatherService.call(latitude, longitude)
                end

            rescue => e

                flash.alert = e.message
            end

        else
            flash.alert = "Please enter a valid address in the form \“4600 Silver Hill Rd, Washington, DC 20233\”"
        end
    end

    private
    
    #regex to check address is in the from 4241354 Street name, city name, state code zipcode"
    def is_correct_format?

        return @address.match? /\A\d+\s+[a-zA-Z]+\s+[a-zA-Z]+[\s]*[a-zA-Z]*[\s]*[,][\s]*[a-zA-Z]+[\s]*[,][\s]*[A-Z][A-Z]\s+\d+[\s]*\Z/

    end
end

