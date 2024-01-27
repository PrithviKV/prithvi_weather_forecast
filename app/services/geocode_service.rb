class GeocodeService

    attr_accessor :address

    def initialize(address)
        @address = address
    end

    def get_url
        
        #prepare the url from the address

        url = ""

        begin
            arr=@address.split(/,/)
            street=arr[0].split.join('+')
            city=arr[1].strip
            state=arr[2].split[0].strip
            zip = arr[2].split[1].strip
            url = "https://geocoding.geo.census.gov/geocoder/locations/address?street=#{street}&city=#{city}&state=#{state}&zip=#{zip}&benchmark=2020&format=json"
        rescue => e
            return e.message
          
        end

        url
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

            longitude=body["result"]["addressMatches"][0]["coordinates"]["x"].round(4)
            latitude=body["result"]["addressMatches"][0]["coordinates"]["y"].round(4)
        rescue

        end
        [latitude, longitude]
    end
end