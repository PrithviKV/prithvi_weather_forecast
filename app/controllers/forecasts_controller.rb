class ForecastsController < ApplicationController
    def index

        @address = params[:address]
        
        address_service = AddressService.new(@address)

        #check address is present and it is in the right format
        if @address && address_service.is_correct_format?
            begin

                # zipcode as weather_cache_key
                @weather_cache_key = address_service.get_address_hash["zipcode"]
                

                @weather_cache_exist = Rails.cache.exist?(@weather_cache_key)

                @data = Rails.cache.fetch(@weather_cache_key, expires_in: 30.minutes) do

                    @geocode = GeocodeService.new(@address)

                    #get longitude and latitude from the address
                    latitude, longitude = @geocode.get_coordinates

                    if latitude != 0 && longitude != 0

                        #get forecast data from Api
                        WeatherService.call(latitude, longitude)
                    end
                end

            rescue => e

                flash.alert = e.message
            end

        else
            flash.alert = "Please enter a valid address in the form \“4600 Silver Hill Rd, Washington, DC 20233\”"
        end
    end
end

