class CsvFilter
  def allowed_fields
    %i[
      territory_name
      street_name
      house_number
      name
      do_not_visit_date
      show
      uuid
      updated_at
    ]
  end

  def filter(input)
    input = input.dup.symbolize_keys
    {}.tap do |filtered|
      allowed_fields.each do |key|
        filtered[key] = input[key]
      end
    end
  end
end
