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
    input.dup.symbolize_keys.tap do |filtered|
      filtered.keys.each do |key|
        filtered.delete(key) unless ALLOWED_KEYS.include?(key)
      end
    end
  end
end
