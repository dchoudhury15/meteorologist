require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    street_address_parsed=@street_address.gsub(" ","+")
    # street_address_parsed="the+corner+of+Sheridan+and+Foster"
    url_googlemaps="https://maps.googleapis.com/maps/api/geocode/json?address="+street_address_parsed+"&key=AIzaSyB3edlxfHYNwG_-lZor-6KMsF4_ChCpVHA"

    parsed_data_gmaps = JSON.parse(open(url_googlemaps).read)
    latitude = parsed_data_gmaps["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data_gmaps["results"][0]["geometry"]["location"]["lng"]

    url_forecast="https://api.darksky.net/forecast/b1f72712a6431503e8f2d2d6e96a04cc/"+latitude.to_s+","+longitude.to_s++"?exclude=[alerts]+[flags]"
    parsed_data_forecast = JSON.parse(open(url_forecast).read)

    @current_temperature = parsed_data_forecast["currently"]["temperature"]

    @current_summary = parsed_data_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_forecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_forecast["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
