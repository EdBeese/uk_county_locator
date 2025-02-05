# frozen_string_literal: true

require 'spec_helper'
require 'yaml'

RSpec.describe UkCountyLocator do
  it 'has a version number' do
    expect(UkCountyLocator::VERSION).not_to be nil
  end

  describe '.find_county' do
    let(:latitude) { 51.4290383462936 }
    let(:longitude) { -0.1658028043302774 }

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
        YAML.load_file(File.join(__dir__, 'fixtures/ceremonial_county_test_coordinates.yml'))['test_coordinates']
      end

      include_examples 'county type matcher', :ceremonial
    end

    describe 'Historic County Locator' do
      let(:coordinates) do
        YAML.load_file(File.join(__dir__, 'fixtures/historic_county_test_coordinates.yml'))['test_coordinates']
      end

      include_examples 'county type matcher', :historic
    end

    describe 'Current County and Unitary Authority Locator' do
      let(:coordinates) do
        YAML.load_file(
          File.join(__dir__, 'fixtures/current_county_and_unitary_authority_test_coordinates.yml')
        )['test_coordinates']
      end

      include_examples 'county type matcher', :current
    end
  end

  describe '.find_polygon' do
    let(:orkney_polygon) { 'hy~LstziJx{gCzkGpg{AhrcAltwDkoFroSlyMgwoD|]u{v@jxv@{~b@jbMwgeAeaBqk`AcenA' }

    it 'returns an error when invalid value argument passed in for county' do
      expect { UkCountyLocator.find_polygon(county: 123) }
        .to raise_error(UkCountyLocator::InvalidArgumentError)
    end

    it 'returns an error when invalid value argument passed in for type' do
      expect { UkCountyLocator.find_polygon(county: 'Hertfordshire', type: :foo) }
        .to raise_error(UkCountyLocator::InvalidArgumentError)
    end

    it 'returns an error when :all value argument passed in for type' do
      expect { UkCountyLocator.find_polygon(county: 'Hertfordshire', type: :all) }
        .to raise_error(UkCountyLocator::InvalidArgumentError)
    end

    it 'will not return an error when string type value argument can be converted to valid type' do
      expect { UkCountyLocator.find_polygon(county: 'Hertfordshire', type: 'Ceremonial') }
        .not_to raise_error
    end

    it 'returns an error when when string type value argument cannot be converted to valid type' do
      expect { UkCountyLocator.find_polygon(county: 'Hertfordshire', type: 'Foo') }
        .to raise_error(UkCountyLocator::InvalidArgumentError)
    end

    context 'when no type argument is passed in' do
      context 'when passed in county matches ceremonial county name' do
        let(:county) { 'Orkney Islands' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county)).to eq(orkney_polygon)
        end
      end

      context 'when passed in county matches ceremonial county aliased name' do
        let(:county) { 'Orkney' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county)).to eq(orkney_polygon)
        end
      end

      context 'when passed in county is in different case' do
        let(:county) { 'ORKnEY iSLANDS' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county)).to eq(orkney_polygon)
        end
      end

      context 'when passed in county is an alias in different case' do
        let(:county) { 'ORKnEY' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county)).to eq(orkney_polygon)
        end
      end

      context 'when passed in county does not match ceremonial county name or aliased name' do
        let(:county) { 'foo' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county)).to be_nil
        end
      end
    end

    context 'when historic type argument is passed in' do
      context 'when passed in county matches historic county name' do
        let(:county) { 'Orkney' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county, type: :historic)).to eq(orkney_polygon)
        end
      end

      context 'when passed in county matches historic county aliased name' do
        let(:county) { 'Arcaibh' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county, type: :historic)).to eq(orkney_polygon)
        end
      end

      context 'when passed in county does not match historic county name or aliased name' do
        let(:county) { 'foo' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county, type: :historic)).to be_nil
        end
      end
    end

    context 'when current type argument is passed in' do
      context 'when passed in county matches current county name' do
        let(:county) { 'Orkney Islands' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county, type: :current)).to eq(orkney_polygon)
        end
      end

      context 'when passed in county matches current county aliased name' do
        let(:county) { 'Arcaibh' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county, type: :current)).to eq(orkney_polygon)
        end
      end

      context 'when passed in county does not match current county name or aliased name' do
        let(:county) { 'foo' }

        it 'returns the encoded polygon string for the passed in county' do
          expect(UkCountyLocator.find_polygon(county: county, type: :current)).to be_nil
        end
      end
    end
  end

  describe '.county_list' do
    it 'returns a list of all ceremonial counties by default' do
      expect(UkCountyLocator.county_list.length).to eq 73
    end

    it 'includes ceremonial counties' do
      expect(UkCountyLocator.county_list).to include('Greater London')
    end

    it 'returns a list of all hitoric counties when argument passed in' do
      expect(UkCountyLocator.county_list(type: :historic).length).to eq 91
    end

    it 'includes hitoric counties' do
      expect(UkCountyLocator.county_list(type: :historic)).to include('Middlesex')
    end

    it 'returns a list of all current counties and unitary authorities by default' do
      expect(UkCountyLocator.county_list(type: :current).length).to eq 218
    end

    it 'includes current counties and unitary authorities' do
      expect(UkCountyLocator.county_list(type: :current)).to include('Wandsworth')
    end
  end
end
