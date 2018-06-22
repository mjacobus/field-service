# frozen_string_literal: true

module ApiResponse
  module Maps
    class Index < BaseResponse
      def initialize(territories:)
        @territories = territories
      end

      def to_h
        { data: data}
      end

      private

      def data
        @territories.map do |territory|
          {
            name: territory.name,
            coordinates: territory.map_coordinates
          }
        end
      end
    end
  end
end
