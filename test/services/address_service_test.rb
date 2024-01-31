require 'test_helper'

class AddressServiceTest < ActiveSupport::TestCase

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

    test "call with invalid address" do
        address = "Bolinger Cmn, Fremont, CA 94539"
        address_service = AddressService.new(address)
        
        assert_equal false, address_service.is_correct_format?
    end

    test "call an address with 2 words in city name" do
        address = "4767 Lafayette St, Santa Clara, CA 95054"
        address_service = AddressService.new(address)
        assert_equal "https://geocoding.geo.census.gov/geocoder/locations/address?street=4767+Lafayette+St&city=Santa+Clara&state=CA&zip=95054&benchmark=2020&format=json", address_service.get_url

        address_hash = address_service.get_address_hash
        assert_equal "4767+Lafayette+St", address_hash["street"]
        assert_equal "Santa+Clara", address_hash["city"]
        assert_equal "CA", address_hash["state"]
        assert_equal "95054", address_hash["zipcode"]
        
        assert_equal true, address_service.is_correct_format?
    end
end

