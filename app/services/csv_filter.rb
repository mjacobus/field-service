class CsvFilter
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
    input = input.dup.symbolize_keys
    {}.tap do |filtered|
      ALLOWED_KEYS.each do |key|
        filtered[key] = input[key]
      end
    end
  end
end
