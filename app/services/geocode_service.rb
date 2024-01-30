require 'net/http'
require 'uri'

class GeocodeService

    attr_accessor :address

    def initialize(address)
        @address = address
        @longitude = 0
        @latitude = 0
    end

    def get_coordinates

        url = AddressService.new(@address).get_url

        if url

            begin
                uri = URI(url)
                res = Net::HTTP.get_response(uri)
                body = JSON.parse(res.body)
                
                if !body["result"]["addressMatches"].empty?
                    @longitude=body["result"]["addressMatches"][0]["coordinates"]["x"].round(4)
                    @latitude=body["result"]["addressMatches"][0]["coordinates"]["y"].round(4)
                end
            rescue => e
                return e.message
            end
        end

        [@latitude, @longitude]
    end
end
