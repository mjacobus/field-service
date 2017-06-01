require 'test_helper'

class CsvImporterTest < ActiveSupport::TestCase
  subject { CsvImporter.new }

  describe '#import' do
    let(:file_path) { FIXTURES_PATH + '/files/csv_example.csv' }

    it 'takes a file and import data' do
      subject.import(file_path)

      assert_equal 2, Householder.count
    end
  end
end
