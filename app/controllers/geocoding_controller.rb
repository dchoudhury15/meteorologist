require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    require 'open-uri'
    street_address_parsed=@street_address.gsub(" ","+")
    # street_address_parsed="the+corner+of+Sheridan+and+Foster"
    url="https://maps.googleapis.com/maps/api/geocode/json?address="+street_address_parsed+"&key=AIzaSyB3edlxfHYNwG_-lZor-6KMsF4_ChCpVHA"

    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


    @latitude = latitude

    @longitude = longitude

    render("geocoding/street_to_coords.html.erb")
  end
end
