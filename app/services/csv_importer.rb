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
    ap contents
    collection = @parser.parse(contents).map(&:symbolize_keys)
    ap collection
    @importer.import_batch(collection)
  end
end
