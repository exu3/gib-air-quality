class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=94506&distance=25&API_KEY=172B0B13-4AD8-4AEA-884A-12A49B2BA603'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    # Check for empty result
    if @output.empty?
      @air_quality = "Error"
    elsif !@output
      @air_quality = "Error"
    else
      @air_quality = @output[0]['AQI']
    end

    if @air_quality == "Error"
      @aqi_color = "gray"
    elsif @air_quality <= 50
      @aqi_color = "green"
    elsif @air_quality >= 51 && @air_quality <= 100
      @aqi_color = "yellow"
    elsif @air_quality >= 101 && @air_quality <= 150
      @aqi_color = "orange"
    elsif @air_quality >= 151 && @air_quality <= 200
      @aqi_color = "red"
    elsif @air_quality >= 201 && @air_quality <= 300
      @aqi_color = "purple"
    elsif @air_quality >= 301 && @air_quality <= 500
      @aqi_color = "maroon"
    end
  end
end
