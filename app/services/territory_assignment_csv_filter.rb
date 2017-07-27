class TerritoryAssignmentCsvFilter < CsvFilter
  def allowed_fields
    %i[
      territory_name
      publisher_name
      assigned_at
      returned_at
    ]
  end
end
