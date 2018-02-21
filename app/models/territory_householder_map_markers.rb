class TerritoryHouseholderMapMarkers
  def initialize(householders)
    @markers = householders.map do |householder|
      if householder.is_a?(TerritoryHouseholderMapMarker)
        next householder
      end

      TerritoryHouseholderMapMarker.new(householder)
    end
  end

  def to_h
    @markers.map(&:to_h)
  end
end
