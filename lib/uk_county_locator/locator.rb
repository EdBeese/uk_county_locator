# frozen_string_literal: true

require_relative 'polylines_service'
require_relative 'polygons/ceremonial_county_polygons'
require_relative 'polygons/historic_county_polygons'
require_relative 'polygons/current_county_and_unitary_authority_polygons'

module UkCountyLocator
  # Locator is responsible for determining the county data (current, ceremonial, or historic)
  # for a given latitude and longitude. It handles both general county data retrieval
  # for all county types or specific retrieval based on a provided type. The class also
  # integrates with the PolylinesService to check if the point lies within the defined county polygons.
  class Locator
    def initialize(lat, lng, type: :all)
      @lat = lat
      @lng = lng
      @type = type
    end

    def county_data
      return specific_county_type(@type) unless @type == :all

      {
        current_county_or_unitary_authority: find_county_within(current_county_and_unitary_authority_polygons),
        ceremonial_county: find_county_within(ceremonial_county_polygons),
        historic_county: find_county_within(historic_county_polygons)
      }
    end

    private

    def specific_county_type(county_type)
      case county_type.downcase
      when :current
        find_county_within(current_county_and_unitary_authority_polygons)
      when :ceremonial
        find_county_within(ceremonial_county_polygons)
      when :historic
        find_county_within(historic_county_polygons)
      end
    end

    def find_county_within(polygons)
      polylines_service.point_inside_polygon?(polygons)
    end

    def polylines_service
      @polylines_service ||= PolylinesService.new(lat: @lat, lng: @lng)
    end

    def current_county_and_unitary_authority_polygons
      Polygons::CurrentCountyAndUnitaryAuthorityPolygons::CURRENT_COUNTY_AND_UNITARY_AUTHORITY_POLYGONS
    end

    def ceremonial_county_polygons
      Polygons::CeremonialCountyPolygons::CEREMONIAL_COUNTY_POLYGONS
    end

    def historic_county_polygons
      Polygons::HistoricCountyPolygons::HISTORIC_COUNTY_POLYGONS
    end
  end
end
