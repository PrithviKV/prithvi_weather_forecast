class ForecastsController < ApplicationController
    def index
        @data = WeatherService.call

    end
end
