module Endpoints
  module Territories
    class UpdateEndpoint
      def perform(slug:, attributes:)
        territory = Territory.find_by_slug(slug)

        if territory.update(attributes)
          return ApiResponse::Territories::Updated.new(territory)
        end

        ApiResponse::ValidationError.new(territory.errors)
      end
    end
  end
end
