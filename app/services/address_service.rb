# Address service represents the postal address we obtain as input
# and methods to verify and geocode it.

class AddressService

    attr_accessor :address

    def initialize(address)
        @address = address
        @street = ""
        @city = ""
        @state = ""
        @zip = ""
        @url = ""
    end

    # Split the address string into its components
    def get_address_hash
        
        arr = @address.split(/,/)
        street = arr[0].split.join('+')
        city = arr[1].strip
        state = arr[2].split[0]
        zip = arr[2].split[1]

        return { "street" => street, "city" => city, "state" => state, "zipcode" => zip }
    end

    # Get the Census GeoCode REST API for this address.
    # This is a free REST API documented here: https://geocoding.geo.census.gov/geocoder/Geocoding_Services_API.html
    def get_url

        address_hash = get_address_hash
        @street = address_hash["street"]
        @city = address_hash["city"]
        @state = address_hash["state"]
        @zipcode = address_hash["zipcode"]

        @url = "https://geocoding.geo.census.gov/geocoder/locations/address?street=#{@street}&city=#{@city}&state=#{@state}&zip=#{@zipcode}&benchmark=2020&format=json"

        @url
    end

    

    # Check for valid address format using regex: "4241354 Street name, city name, state code zipcode"
    def is_correct_format?

        return @address.match? /\A[0-9]*\s+[a-zA-Z]+\s+[a-zA-Z]+[\s]*[a-zA-Z]*[\s]*[,][\s]*[a-zA-Z]+[\s]*[,][\s]*[A-Z][A-Z]\s+\d+[\s]*\Z/

    end
end

