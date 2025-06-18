# frozen_string_literal: true

require 'polylines'
require 'geokit'
require 'parallel'
require 'rgeo'

# PolylinesService handles the decoding of polygon polyline data and provides
# functionality to check if a given point (latitude, longitude) lies within
# any of the provided polygons. It supports batch processing of multiple
# polygons using parallel processing to improve performance.
class PolylinesService
  def initialize(lat:, lng:)
    @point = RGeo::Geos.factory.point(lng, lat)
  end

  def polygon_to_array(polygon:)
    Polylines::Decoder.decode_polyline(polygon).map do |lng, lat|
      RGeo::Geos.factory.point(lng, lat)
    end
  end

  def point_inside_polygon?(decoded_polygons)
    return nil if @point.nil?

    decoded_polygons.find do |_name, data|
      next unless data[:bbox].contains?(@point)

      data[:polygon].contains?(@point)
    end&.first
  end
end
