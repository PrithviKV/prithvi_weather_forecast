class ForecastsController < ApplicationController
    def index
        address = "4600 Silver Hill Rd, Washington, DC 20233 "
        # address = "454 Bolinger Cmn, Fremont, CA 94539"

        return "Please enter a valid address in the form \“4600 Silver Hill Rd, Washington, DC 20233\”"if address.nil?

        begin

          @data = WeatherService.call(address)

        rescue => e

          @data = e.message

        end

    end
end
