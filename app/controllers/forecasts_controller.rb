# ForecastsController has the main logic of this weather forecast application.
# 
# It goes through these steps:
# 1. Verify the input postal address.
# 2. Extract the zipcode from the postal address.
# 3. Fetch the forecast from the cache, if it already has this zipcode.
# 4. Else, convert address to (latitude, longitude) using a GeoCoding REST API.
# 5. Get the forecast for the (lat, long) using the National Weather Service REST API.

class ForecastsController < ApplicationController

    def index

        @address = params[:address]
        
        address_service = AddressService.new(@address)

        # Check address is present and it is in the right format
        if @address && address_service.is_correct_format?
            begin

                # Extract the zipcode from the address.
                # We use the zipcode as the key to our 30-minute cache.
                @weather_cache_key = address_service.get_address_hash["zipcode"]

                # check if we already have a forecast for this zipcode.
                @weather_cache_exist = Rails.cache.exist?(@weather_cache_key)

                # Extract forecast from cache, if not already cached get from API 
                # and write to cache
                @data = Rails.cache.fetch(@weather_cache_key, expires_in: 30.minutes) do

                    # Get the geocode for our address using free Census Geocoding REST API
                    @geocode = GeocodeService.new(@address)

                    # Get longitude and latitude from the address
                    latitude, longitude = @geocode.get_coordinates

                    if latitude != 0 && longitude != 0

                        # Get forecast data from free NWS REST API.
                        WeatherService.call(latitude, longitude)
                    end
                end

            rescue => e

                flash.alert = e.message
            end

        else
            flash.alert = "Cannot process this address. Please ensure it is in this format: \“4600 Silver Hill Rd, Washington, DC 20233\”"
        end
    end
end

