# frozen_string_literal: true

require 'polylines'
require 'geokit'

# PolylinesService handles the decoding of polygon polyline data and provides
# functionality to check if a given point (latitude, longitude) lies within
# any of the provided polygons.
class PolylinesService
  def initialize(lat:, lng:)
    @point = Geokit::LatLng.new(lat, lng)
  end

  def polygon_to_array(polygon:)
    Polylines::Decoder.decode_polyline(polygon).map { |lng, lat| Geokit::LatLng.new(lat, lng) }
  end

  def point_inside_polygon?(polygons)
    return nil if @point.nil?

    polygons.detect do |name, polygon|
      geo_polygon = Geokit::Polygon.new(polygon_to_array(polygon: polygon))
      geo_polygon.contains?(@point) ? name : nil
    end.first
  end
end
