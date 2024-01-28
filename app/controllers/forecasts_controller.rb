class ForecastsController < ApplicationController
    def index

        @address = params[:address]
        
        #check address is present and it is in the right format
        if @address && is_correct_format?
            begin

                @data = WeatherService.call(@address)

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
