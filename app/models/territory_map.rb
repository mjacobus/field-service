class TerritoryMap
  attr_reader :coordinates
  attr_reader :markers

  def initialize(coordinates:, markers: [], geolocation_service: GeolocationService.new)
    @markers = markers || []
    @coordinates = coordinates || []
    @geolocation_service = geolocation_service
  end

  def center
    if coordinates.empty?
      return markers.center
    end

    @geolocation_service.center_of(coordinates)
  end

  def to_h
    { coordinates: coordinates, center: center, markers: markers.to_h }
  end
end
