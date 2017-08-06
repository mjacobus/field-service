require 'spec_helper'

RSpec.describe StreetNameNormalizer do
  describe '#normalized_street_name' do
    it 'normalizes street names' do
      streets = {
        'Ditmar-Koel-Str.' => 'Ditmar-Koel-Straße',
        'Ditmar-Koel-str.' => 'Ditmar-Koel-straße',
        'somethingstr'     => 'somethingstraße',
        'somethingstrasse' => 'somethingstraße',
        'somethingstrabic' => 'somethingstrabic'
      }

      streets.each do |raw, normalized|
        expect(subject.normalize(raw)).to eq(normalized)
      end
    end
  end
end
