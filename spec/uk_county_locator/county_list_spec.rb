# frozen_string_literal: true

require 'spec_helper'
require 'yaml'

RSpec.describe UkCountyLocator do
  describe '.county_list' do
    it 'returns a list of all ceremonial counties by default' do
      expect(UkCountyLocator.county_list.length).to eq 73
    end

    it 'includes ceremonial counties' do
      expect(UkCountyLocator.county_list).to include('Greater London')
    end

    it 'returns a list of all ceremonial counties if type is explicitly nil' do
      expect(UkCountyLocator.county_list(type: nil).length).to eq 73
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
