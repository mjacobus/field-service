require 'rails_helper'

RSpec.describe CsvImporter do
  describe '#import' do
    let(:file_path) { FIXTURES_PATH + '/files/csv_example.csv' }

    it 'takes a file and import data' do
      subject.import(file_path)

      expect(Householder.count).to eq(2)
    end
  end
end
