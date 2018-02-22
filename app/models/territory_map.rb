class TerritoryMap
  attr_reader :coordinates
  attr_reader :average_latitude
  attr_reader :average_longitude

  def initialize(coordinates:, markers: [], geolocation_service: GeolocationService.new)
    @markers = markers || []
    @coordinates = coordinates || []
    @geolocation_service = geolocation_service

    if @coordinates.length > 1
      @average_latitude = coordinates_average('lat')
      @average_longitude = coordinates_average('lng')
    end
  end

  def center
    if @coordinates.empty?
      return @markers.center
    end

    @geolocation_service.center_of(@coordinates)
  end

  def to_h
    { coordinates: coordinates, center: center, markers: @markers.to_h }
  end

  private

  def coordinates_average(type)
    numbers = coordinates.map { |c| c[type] }
    min = numbers.min
    max = numbers.max
    min + (max - min) / 2
  end
end
