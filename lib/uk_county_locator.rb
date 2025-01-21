# frozen_string_literal: true

require_relative 'uk_county_locator/version'
require_relative 'uk_county_locator/locator'

# UkCountyLocator module provides functionality for locating counties
# in the UK based on latitude and longitude coordinates. It supports
# different types of county information, including historical, ceremonial,
# and current county/ Unitary Authority data. The main method, `find_county`,
# returns the relevant county data for the provided coordinates and type.
module UkCountyLocator
  class Error < StandardError; end

  def self.find_county(lat, lng, type: :ceremonial)
    Locator.new(lat, lng, type: type).county_data
  end
end
