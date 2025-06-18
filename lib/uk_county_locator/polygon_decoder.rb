# frozen_string_literal: true

module UkCountyLocator
  # Module with reusable logic to decode the county polyline strings and keep them cached
  module PolygonDecoder
    def self.decoded_county_polygons(polygons)
      polygons.transform_values do |encoded_polyline|
        points = Polylines::Decoder.decode_polyline(encoded_polyline)
        point_objs = points.map { |lng, lat| RGeo::Geos.factory.point(lng, lat) }
        {
          points: point_objs,
          polygon: RGeo::Geos.factory.polygon(RGeo::Geos.factory.linear_ring(point_objs)),
          bbox: build_bounding_box(point_objs)
        }
      end
    end

    def self.build_bounding_box(point_objs)
      bbox = RGeo::Cartesian::BoundingBox.new(RGeo::Geos.factory)
      point_objs.each { |pt| bbox.add(pt) }
      bbox
    end
  end
end
