class ForecastsController < ApplicationController
    def index

        @address = params[:address]
        
        if @address
            begin

                @data = WeatherService.call(@address)

            rescue => e

                flash.alert = e.message
            end

        else
            flash.alert = "Please enter a valid address in the form \“4600 Silver Hill Rd, Washington, DC 20233\”"
        end
    end
end

