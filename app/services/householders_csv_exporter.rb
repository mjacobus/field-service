require 'csv'

class HouseholdersCsvExporter
  def initialize
    @fields = CsvFilter::ALLOWED_KEYS
    @filter = CsvFilter.new
  end

  # @return FileExportService
  def export(householders)
    csv_string = CSV.generate(col_sep: ';') do |csv|
      csv << @fields
      householders.each do |householder|
        csv << householder_to_csv_row(householder)
      end
    end

    FileExportService.new(csv_string)
  end

  private

  def householder_to_csv_row(householder)
    attributes = householder.attributes.merge(
      territory_name: householder.territory.name,
      show: householder.show? ? 1 : 0,
      updated_at: householder.updated_at.utc.to_s(:db)
    )

    @filter.filter(attributes).values
  end
end
