# frozen_string_literal: true

require_relative 'polygons/ceremonial_county_polygons'
require_relative 'polygons/historic_county_polygons'
require_relative 'polygons/current_county_and_unitary_authority_polygons'
require_relative 'aliases/ceremonial_county_aliases'
require_relative 'aliases/historic_county_aliases'
require_relative 'aliases/current_county_and_unitary_authority_aliases'

module UkCountyLocator
  # The `UkCountyLocator::PolygonFetcher` retrieves geographic polygon data for UK counties.
  # Supports `:current`, `:ceremonial`, and `:historic` county types.
  # The class supports a large number of aliases for each county, stored in the aliases directory.
  class PolygonFetcher
    def initialize(type:)
      @type = type
      @counties = fetch_county_polygons.transform_keys(&:downcase)
    end

    def county_polygon(county)
      county = county.downcase
      return @counties[county] if @counties[county]
      return @counties[county_by_alias(county)] if @counties[county_by_alias(county)]

      nil
    end

    private

    def fetch_county_polygons
      case @type
      when :current
        current_county_and_unitary_authority_polygons
      when :ceremonial
        ceremonial_county_polygons
      when :historic
        historic_county_polygons
      end
    end

    def county_by_alias(county)
      case @type
      when :current
        current_county_and_unitary_authority_aliases[county]&.downcase
      when :ceremonial
        ceremonial_county_aliases[county]&.downcase
      when :historic
        historic_county_aliases[county]&.downcase
      end
    end

    def current_county_and_unitary_authority_polygons
      Polygons::CurrentCountyAndUnitaryAuthorityPolygons::CURRENT_COUNTY_AND_UNITARY_AUTHORITY_POLYGONS
        .transform_keys(&:downcase)
    end

    def ceremonial_county_polygons
      Polygons::CeremonialCountyPolygons::CEREMONIAL_COUNTY_POLYGONS.transform_keys(&:downcase)
    end

    def historic_county_polygons
      Polygons::HistoricCountyPolygons::HISTORIC_COUNTY_POLYGONS.transform_keys(&:downcase)
    end

    def current_county_and_unitary_authority_aliases
      Aliases::CurrentCountyAndUnitaryAuthorityAliases::CURRENT_COUNTY_AND_UNITARY_AUTHORITY_ALIASES
        .transform_keys(&:downcase)
    end

    def ceremonial_county_aliases
      Aliases::CeremonialCountyAliases::CEREMONIAL_COUNTY_ALIASES.transform_keys(&:downcase)
    end

    def historic_county_aliases
      Aliases::HistoricCountyAliases::HISTORIC_COUNTY_ALIASES.transform_keys(&:downcase)
    end
  end
end
