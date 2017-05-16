require 'test_helper'

class CsvImporterTest < ActiveSupport::TestCase
  subject { CsvImporter.new }

  describe '#import' do
    let(:file_path) { FIXTURES_PATH + '/files/csv_example.csv' }

    it 'takes a file and import data' do
      subject.import(file_path)

      assert_equal 2, Householder.count
      assert_equal 1, Territory.count
    end
  end
end

class CsvImporter::FilterTest < ActiveSupport::TestCase
  subject { CsvImporter::Filter.new }

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
