# frozen_string_literal: true

require_relative 'uk_county_locator/argument_validator'
require_relative 'uk_county_locator/locator'
require_relative 'uk_county_locator/polygon_fetcher'
require_relative 'uk_county_locator/version'

# UkCountyLocator module provides functionality for locating counties
# in the UK based on latitude and longitude coordinates. It supports
# different types of county information, including historical, ceremonial,
# and current county/ Unitary Authority data. The main method, `find_county`,
# returns the relevant county data for the provided coordinates and type.
# The method `find_polygon` will return the polygon for the requested county and type.
module UkCountyLocator
  class Error < StandardError; end
  class InvalidArgumentError < Error; end

  def self.find_county(lat:, lng:, type: :ceremonial)
    validated_params = ArgumentValidator.new(request: :county, type: type, lat: lat, lng: lng)

    Locator.new(validated_params.lat, validated_params.lng, type: validated_params.type).county_data
  end

  def self.find_polygon(county:, type: :ceremonial)
    validated_params = ArgumentValidator.new(request: :data, type: type, county: county)

    PolygonFetcher.new(type: validated_params.type).county_polygon(county)
  end

  def self.county_list(type: :ceremonial)
    validated_params = ArgumentValidator.new(request: :data, type: type)

    PolygonFetcher.new(type: validated_params.type).county_list
  end
end
