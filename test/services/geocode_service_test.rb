require 'test_helper'

class GeocodeServiceTest < ActiveSupport::TestCase

    #get lat, long for a valid address
    test "call with valid address" do
        address = "454 Bolinger Cmn, Fremont, CA 94539"
        geocode = GeocodeService.new(address)
        
        coordinates = geocode.get_coordinates
        assert_in_delta -121.92259, coordinates[1], 0.1
        assert_in_delta 37.48664, coordinates[0], 0.1
    end

    #get lat, long for an invalid address
    test "call with invalid address" do
        address = "4 Br Cmn, Fr, CA 9"
        geocode = GeocodeService.new(address)
        
        coordinates = geocode.get_coordinates
        assert_in_delta 0, coordinates[1], 0.1
        assert_in_delta 0, coordinates[0], 0.1

    end
end

