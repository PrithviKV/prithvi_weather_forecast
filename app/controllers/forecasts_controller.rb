class ForecastsController < ApplicationController
    def index
        address = "4600 Silver Hill Rd, Washington, DC 20233 "
        # address = "454 Bolinger Cmn, Fremont, CA 94539"
        @data = WeatherService.call(address)  #("454 Bolinger Cmn, Fremont, CA 94539")

    end
end
