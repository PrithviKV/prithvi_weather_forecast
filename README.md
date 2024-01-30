# Prithvi's Weather Forecast

A Rails web application to retrieve weather forecast information for a given postal address.

Provide a US postal address in a valid USPS format and you get the weather forecast ( temperature, wind and rain) for the next few hours.
If addresses from the same zipcode are queried within 30 minutes, we use the Rails cache to retrieve the forecast without hitting the REST APIs.

# Details

After Googling around a bit on how to retrieve weather info, I find two options:

1. Use Ruby gems to pull from sources like OpenWeatherMap. These require an API key.
2. Use [REST API](https://weather-gov.github.io/api/general-faqs) provided for free by National Weather Service (NWS).

Since the information we are pulling is pretty simple, option (2) seems like a lightweight solution.

However, the NWS API takes a (latitude, longitude) input, so we need a way to convert an address (or zipcode) into lat-long.

This seems to be called GeoCoding and the helpful NWS FAQ page points to a [GeoCoding REST API](https://geocoding.geo.census.gov/geocoder/Geocoding_Services_API.html) maintained by the Census Bureau.

Once this was figured out it was pretty simple to build the app.
The only complication was figuring out that the X and Y values in the Geocode response was actually (long, lat) and not (lat, long).

This app is build with Rails 7.0.8 and Ruby 3.2.0

![alt text](/public/Screenshot%20from%202024-01-30%2000-14-24.png)

