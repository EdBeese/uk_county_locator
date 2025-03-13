# frozen_string_literal: true

require 'spec_helper'
require 'yaml'

RSpec.describe UkCountyLocator do
  describe '.find_polygon' do
    let(:orkney_polygon) { 'hy~LstziJx{gCzkGpg{AhrcAltwDkoFroSlyMgwoD|]u{v@jxv@{~b@jbMwgeAeaBqk`AcenA' }

    it 'returns an error when nil value argument passed in for county' do
      expect { UkCountyLocator.find_polygon(county: nil) }
        .to raise_error(UkCountyLocator::InvalidArgumentError)
    end

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

    context 'when nil value is explicitly passed in for type' do
      let(:county) { 'Orkney Islands' }

      it 'returns the encoded polygon string for the passed in county - ceremonial type' do
        expect(UkCountyLocator.find_polygon(county: county, type: nil)).to eq(orkney_polygon)
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
end
