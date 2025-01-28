# frozen_string_literal: true

module UkCountyLocator
  # Class that encompasses all validations on user input
  class ArgumentValidator
    attr_reader :type, :lat, :lng, :county

    VALID_COUNTY_TYPES = %i[current ceremonial historic].freeze

    def initialize(request:, type:, lat: nil, lng: nil, county: nil)
      @request = request
      @type = verified_type(type)
      @lat = parse_coordinate(lat, 'lat') if lat
      @lng = parse_coordinate(lng, 'lat') if lat
      @county = validated_county(county) if county
    end

    private

    def verified_type(type)
      type = type&.downcase&.to_sym
      return type if valid_county_type?(type)

      raise InvalidArgumentError, "Invalid input: type must be one of :current, :ceremonial, :historic.#{all_message}"\
      ", got #{type}"
    end

    def valid_county_type?(type)
      return true if type == :all && @request == :county

      VALID_COUNTY_TYPES.include?(type)
    end

    def parse_coordinate(value, name)
      if value.is_a?(String)
        Float(value)
      elsif value.is_a?(Numeric)
        value.to_f
      else
        raise InvalidArgumentError, "Expected #{name} to be Numeric or a String, got #{value.class}"
      end
    rescue ArgumentError
      raise InvalidArgumentError, "Invalid #{name} format: '#{value}'"
    end

    def validated_county(county)
      return county if county.is_a?(String)

      raise InvalidArgumentError, "Expected county to be a String, got #{county.class}"
    end

    def all_message
      @request == :county ? ', or :all' : ''
    end
  end
end
