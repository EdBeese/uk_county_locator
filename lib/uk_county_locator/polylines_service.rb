# frozen_string_literal: true

require 'polylines'
require 'geokit'
require 'parallel'

# PolylinesService handles the decoding of polygon polyline data and provides
# functionality to check if a given point (latitude, longitude) lies within
# any of the provided polygons. It supports batch processing of multiple
# polygons using parallel processing to improve performance.
class PolylinesService
  def initialize(lat:, lng:)
    @point = Geokit::LatLng.new(lat, lng)
  end

  def polygon_to_array(polygon:)
    Polylines::Decoder.decode_polyline(polygon).map { |lng, lat| Geokit::LatLng.new(lat, lng) }
  end

  def point_inside_polygon?(polygons)
    return nil if @point.nil?

    result = Parallel.map(polygons, in_processes: 4) do |name, polygon|
      geo_polygon = Geokit::Polygon.new(polygon_to_array(polygon: polygon))

      geo_polygon.contains?(@point) ? name : nil
    end

    result.compact.first
  end
end
