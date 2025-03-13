# frozen_string_literal: true

require 'spec_helper'
require 'yaml'

RSpec.describe UkCountyLocator do
  describe '.find_county' do
    let(:latitude) { 51.4290383462936 }
    let(:longitude) { -0.1658028043302774 }

    it 'returns an error when lat or lng is nil class' do
      expect { UkCountyLocator.find_county(lat: nil, lng: longitude) }
        .to raise_error(UkCountyLocator::InvalidArgumentError)
    end

    it 'returns an error when lat or lng is invalid class' do
      expect { UkCountyLocator.find_county(lat: [], lng: []) }.to raise_error(UkCountyLocator::InvalidArgumentError)
    end

    it 'returns an error when lat or lng is string that cannot be converted to float' do
      expect { UkCountyLocator.find_county(lat: 'foo', lng: 'bar') }
        .to raise_error(UkCountyLocator::InvalidArgumentError)
    end

    it 'does not return an error when lat or lng is string that can be converted to float' do
      expect { UkCountyLocator.find_county(lat: latitude.to_s, lng: longitude.to_s) }.not_to raise_error
    end

    context 'when no county type argument is passed in' do
      it 'returns the Ceremonial County by default' do
        expect(UkCountyLocator.find_county(lat: latitude, lng: longitude)).to eq('Greater London')
      end
    end

    context 'when explicit nil county type argument is passed in' do
      it 'returns the Ceremonial County by default' do
        expect(UkCountyLocator.find_county(lat: latitude, lng: longitude, type: nil)).to eq('Greater London')
      end
    end

    context 'when historic county type argument is passed in' do
      it 'returns the Historic County' do
        expect(UkCountyLocator.find_county(lat: latitude, lng: longitude, type: :historic)).to eq('Surrey')
      end
    end

    context 'when current county/ unitary authority type argument is passed in' do
      it 'returns the Historic County' do
        expect(UkCountyLocator.find_county(lat: latitude, lng: longitude, type: :current)).to eq('Wandsworth')
      end
    end

    context 'when all county type argument is passed in' do
      let(:expected_result) do
        {
          current_county_or_unitary_authority: 'Wandsworth',
          ceremonial_county: 'Greater London',
          historic_county: 'Surrey'
        }
      end

      it 'returns a hash with all three county types' do
        expect(UkCountyLocator.find_county(lat: latitude, lng: longitude, type: :all)).to eq(expected_result)
      end
    end

    describe 'Ceremonial County Locator' do
      let(:coordinates) do
        YAML.load_file(File.join(__dir__, '../fixtures/ceremonial_county_test_coordinates.yml'))['test_coordinates']
      end

      include_examples 'county type matcher', :ceremonial
    end

    describe 'Historic County Locator' do
      let(:coordinates) do
        YAML.load_file(File.join(__dir__, '../fixtures/historic_county_test_coordinates.yml'))['test_coordinates']
      end

      include_examples 'county type matcher', :historic
    end

    describe 'Current County and Unitary Authority Locator' do
      let(:coordinates) do
        YAML.load_file(
          File.join(__dir__, '../fixtures/current_county_and_unitary_authority_test_coordinates.yml')
        )['test_coordinates']
      end

      include_examples 'county type matcher', :current
    end
  end
end
