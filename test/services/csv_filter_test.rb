require 'test_helper'

class CsvFilterTest < ActiveSupport::TestCase
  subject { CsvFilter.new }

  let(:input) do
    {
      territory_name: 'territory name',
      street_name: 'street name',
      house_number: 'house number',
      name: 'the name',
      'show' => 'the show',
      uuid: 'the uuid',
      updated_at: 'the updated at',
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
        show: 'the show',
        uuid: 'the uuid',
        updated_at: 'the updated at'
      }

      assert_equal expected, subject.filter(input)
    end
  end
end
