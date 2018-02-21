class StreetNameNormalizer
  def normalize(street_name)
    street_name.to_s
               .gsub('str.', 'straße')
               .gsub('Str.', 'Straße')
               .gsub(/str(asse)?$/, 'straße')
  end
end
