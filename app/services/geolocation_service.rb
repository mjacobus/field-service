class GeolocationService
  def center_of(geolocations)
    geolocations = geolocations.map(&:symbolize_keys)

    geolocations = geolocations.reject do |geolocation|
      geolocation[:lat].nil? || geolocation[:lng].nil?
    end

    numbers = geolocations.each_with_object(lat: [], lng: []) do |item, data|
      data[:lat].push(Float(item[:lat]))
      data[:lng].push(Float(item[:lng]))
    end

    lat = geolocation_center(numbers[:lat])
    lng = geolocation_center(numbers[:lng])

    present = [lat, lng].compact.any?

    { lat: lat, lng: lng, present: present }
  end

  private

  def geolocation_center(numbers)
    max = numbers.max
    min = numbers.min

    if max == min
      return max
    end

    min + (max - min) / 2
  end
end
