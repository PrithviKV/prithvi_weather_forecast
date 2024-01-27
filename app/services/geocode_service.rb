class GeocodeService

    attr_accessor :address

    def initialize(address)
        @address = address
    end

    def get_url
        
        #prepare the url from the address
        arr=@address.split(/,/)
        street=arr[0].split.join('+')
        city=arr[1].strip
        state=arr[2].split[0].strip
        url = "https://geocoding.geo.census.gov/geocoder/locations/address?street=#{street}&city=#{city}&state=#{state}&benchmark=2020&format=json"

        url
    end

    def get_coordinates
        
        url = get_url
        uri = URI(url)
        res = Net::HTTP.get_response(uri)
        body = JSON.parse(res.body)

        longitude=body["result"]["addressMatches"][0]["coordinates"]["x"].round(4)
        latitude=body["result"]["addressMatches"][0]["coordinates"]["y"].round(4)

        [latitude, longitude]
    end
end