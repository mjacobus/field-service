require 'rails_helper'

RSpec.describe CsvFilter do
  let(:input) do
    {
      street_name: 'street name',
      territory_name: 'territory name',
      house_number: 'house number',
      name: 'the name',
      uuid: 'the uuid',
      'show' => 'the show',
      updated_at: 'the updated at',
      do_not_visit_date: 'the-date',
      foo: 'the updated at',
      nil: nil,
      nil =>  nil
    }
  end

  describe '#filter' do
    it 'removes unwanted keys' do
      expected = {
        territory_name: 'territory name',
        street_name: 'street name',
        house_number: 'house number',
        name: 'the name',
        do_not_visit_date: 'the-date',
        show: 'the show',
        uuid: 'the uuid',
        updated_at: 'the updated at'
      }

      expect(subject.filter(input)).to eq(expected)
    end
  end
end
