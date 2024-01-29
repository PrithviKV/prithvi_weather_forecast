require 'net/http'
require 'uri'

class GeocodeService

    attr_accessor :address

    def initialize(address)
        @address = address
    end

    def get_url
        
        #prepare the url from the address

        url = ""

        begin
            address_hash = get_address_hash
            @street = address_hash["street"]
            @city = address_hash["city"]
            @state = address_hash["state"]
            @zipcode = address_hash["zipcode"]

            url = "https://geocoding.geo.census.gov/geocoder/locations/address?street=#{@street}&city=#{@city}&state=#{@state}&zip=#{@zipcode}&benchmark=2020&format=json"

        rescue => e
            return e.message
        end

        url
    end

    def get_address_hash

        arr=@address.split(/,/)
        street=arr[0].split.join('+')
        city=arr[1].strip
        state=arr[2].split[0]
        zip = arr[2].split[1]
        return { "street" => street, "city" => city, "state" => state, "zipcode" => zip }

    end

    def get_coordinates

        url = get_url

        return if !url

        longitude = 0
        latitude = 0

        begin
            uri = URI(url)
            res = Net::HTTP.get_response(uri)
            body = JSON.parse(res.body)
            
            if !body["result"]["addressMatches"].empty?
                longitude=body["result"]["addressMatches"][0]["coordinates"]["x"].round(4)
                latitude=body["result"]["addressMatches"][0]["coordinates"]["y"].round(4)
            end
        rescue => e
            return e.message
        end

        [latitude, longitude]
    end
end