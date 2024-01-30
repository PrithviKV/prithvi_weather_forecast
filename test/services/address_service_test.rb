require 'test_helper'

class AddressServiceTest < ActiveSupport::TestCase

    # Check valid address format
    test "call with valid address" do
        address = "454 Bolinger Cmn, Fremont, CA 94539"
        address_service = AddressService.new(address)
        assert_equal "https://geocoding.geo.census.gov/geocoder/locations/address?street=454+Bolinger+Cmn&city=Fremont&state=CA&zip=94539&benchmark=2020&format=json", address_service.get_url
        
        address_hash = address_service.get_address_hash
        assert_equal "454+Bolinger+Cmn", address_hash["street"]
        assert_equal "Fremont", address_hash["city"]
        assert_equal "CA", address_hash["state"]
        assert_equal "94539", address_hash["zipcode"]
        
        assert_equal true, address_service.is_correct_format?
    end

    #check invalid address format
    test "call with invalid address" do
        address = "Bolinger Cmn, Fremont, CA 94539"
        address_service = AddressService.new(address)
        
        assert_equal false, address_service.is_correct_format?
    end
end
