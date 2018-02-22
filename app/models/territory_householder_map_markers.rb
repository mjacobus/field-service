class TerritoryHouseholderMapMarkers
  def initialize(householders, geolocation_service: GeolocationService.new)
    @geolocation_service = geolocation_service

    @markers = householders.map do |householder|
      if householder.is_a?(TerritoryHouseholderMapMarker)
        next householder
      end

      TerritoryHouseholderMapMarker.new(householder)
    end
  end

  def center
    @geolocation_service.center_of(@markers.map(&:geolocation))
  end

  def with_geolocation
    self.class.new(
      @markers.select(&:has_geolocation?),
      geolocation_service: @geolocation_service
    )
  end

  def map(&block)
    @markers.map(&block)
  end

  def to_h
    @markers.map(&:to_h)
  end
end
