# frozen_string_literal: true

require 'benchmark'

RSpec.shared_examples 'county type matcher' do |county_type|
  it "returns the correct county for #{county_type}" do
    time = Benchmark.realtime do
      coordinates.each do |test_case|
        result = UkCountyLocator.find_county(lat: test_case['lat'], lng: test_case['lng'], type: county_type)
        expect(result).to eq(test_case['expected'])
      end
    end
    puts "Total time for #{county_type}: #{time.round(4)} seconds"
  end
end
