# frozen_string_literal: true

RSpec.shared_examples 'county type matcher' do |county_type|
  it "returns the correct county for #{county_type}" do
    coordinates.each do |test_case|
      result = UkCountyLocator.find_county(test_case['lat'], test_case['lng'], type: county_type)
      expect(result).to eq(test_case['expected'])
    end
  end
end
