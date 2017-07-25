require 'koine/csv'

class CsvImporter
  def initialize(
    parser: ::Koine::Csv::NamedColumnsParser.new(column_separator: ';'),
    importer: HouseholderImporter.new
  )
    @parser = parser
    @importer = importer
  end

  def import(file)
    contents = File.read(file)
    filter = CsvFilter.new
    collection = @parser.parse(contents).map do |row|
      filter.filter(row)
    end
    @importer.import_batch(collection)
  end
end
