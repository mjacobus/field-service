require 'koine/csv'

class CsvImporter
  def initialize(
    parser: ::Koine::Csv::NamedColumnsParser.new(column_separator: ','),
    importer: HouseholderImporter.new
  )
    @parser = parser
    @importer = importer
  end

  def import(file)
    contents = File.read(file)
    filter = Filter.new
    collection = @parser.parse(contents).map do |row|
      row = filter.filter(row)
      ap row
    end
    @importer.import_batch(collection)
  end

  class Filter
    ALLOWED_KEYS = %i[
      territory_name
      street_name
      house_number
      name
      show
      uuid
      updated_at
    ].freeze

    def filter(input)
      input.dup.symbolize_keys.tap do |filtered|
        filtered.keys.each do |key|
          filtered.delete(key) unless ALLOWED_KEYS.include?(key)
        end
      end
    end
  end
end
