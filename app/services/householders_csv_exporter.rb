require 'csv'

class HouseholdersCsvExporter
  def initialize
    @filter = CsvFilter.new
    @fields = @filter.allowed_fields
  end

  # @return FileExportService
  def export(householders)
    csv_string = CSV.generate do |csv|
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
