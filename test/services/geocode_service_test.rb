require 'test_helper'

class GeocodeServiceTest < ActiveSupport::TestCase
    test "call with valid address" do
        address = "454 Bolinger Cmn, Fremont, CA 94539"
        geocode = GeocodeService.new(address)
        assert_equal "https://geocoding.geo.census.gov/geocoder/locations/address?street=454+Bolinger+Cmn&city=Fremont&state=CA&zip=94539&benchmark=2020&format=json", geocode.get_url
        
        coordinates = geocode.get_coordinates
        assert_in_delta -121.92259, coordinates[1], 0.1
        assert_in_delta 37.48664, coordinates[0], 0.1
    end

    test "call with invalid address" do
        address = "454 Bolinger Fremont, CA 94539"
        geocode = GeocodeService.new(address)
        assert_equal "", geocode.get_url
        
        coordinates = geocode.get_coordinates
        assert_equal 0, coordinates[1]
        assert_equal 0, coordinates[0]
    end
end
