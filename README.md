# Prithvi's Weather Forecast

A web application to retrieve weather forecast information for a given address.

After Googling around a bit on how to retrieve weather info, I find two options:

1. Use Ruby gems to pull from sources like OpenWeatherMap. These require an API key.
2. Use [REST API](https://weather-gov.github.io/api/general-faqs) provided for free by National Weather Service (NWS).

Since the information we are pulling is pretty simple, option (2) seems like a lightweight solution.

However, the NWS API takes a (latitude, longitude) input, so we need a way to convert an address (or zipcode) into lat-long.

This seems to be called GeoCoding and the helpful NWS FAQ page points to a [GeoCoding REST API](https://geocoding.geo.census.gov/geocoder/Geocoding_Services_API.html) maintained by the Census Bureau.

This is a first attempt to try these options and see how it goes.

