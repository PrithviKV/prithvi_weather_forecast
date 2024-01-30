require 'test_helper'

class WeatherServiceTest < ActiveSupport::TestCase
    test "call with valid corrdinates" do
        coordinate_y, coordinate_x = 38.846, -76.9275
        weather_object = WeatherService.call(coordinate_y, coordinate_x)

        assert_not_nil weather_object

    end

    test "call with invalid coordinates" do
        coordinate_y, coordinate_x = 0.846, -0.9275
        weather_object = WeatherService.call(coordinate_y, coordinate_x)

        assert_nil weather_object
    end
end