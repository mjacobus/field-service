require 'koine/csv'

class CsvImporter
  def initialize(
    parser: ::Koine::Csv::NamedColumnsParser.new(column_separator: ','),
    filter: CsvFilter.new,
    importer: HouseholderImporter.new
  )
    @parser = parser
    @importer = importer
    @filter = filter
  end

  def import(file)
    contents = File.read(file)
    collection = @parser.parse(contents).map do |row|
      @filter.filter(row)
    end
    @importer.import_batch(collection)
  end
end
