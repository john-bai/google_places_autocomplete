# Google Places Autocomplete (without response deserialization)

Ruby wrapper for the [Google Places Autocomplete API](http://code.google.com/apis/maps/documentation/places/autocomplete.html).

Uses curb as a HTTP client. HTTP Responses are NOT deserialized, allowing a web application to serve the raw
response from Google.

## Installation

Inside your Gemfile:   
gem 'google_places_autocomplete', :git => 'https://github.com/jtherrell/google_places_autocomplete.git'
    
## Get Google Places API credentials

Go here and activate it:   
[https://code.google.com/apis/console](https://code.google.com/apis/console)
    
## Configuration

    GooglePlacesAutocomplete.configure do |c|
      c.api_key = 'your_api_key'
    end
    
## Usage

    google_response = GooglePlacesAutocomplete.Client.autocomplete(:input => "Paris", :types => "geocode")

## Copyright

Copyright (c) 2009 Johnny Khai Nguyen, released under the MIT license
