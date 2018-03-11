module Endpoints
  module Territories
    class UpdateEndpoint < AdminEndpoint
      private

      def perform_as_admin(slug:, attributes:)
        territory = Territory.find_by_slug(slug)

        if territory.update(attributes)
          return ApiResponse::Territories::Updated.new(territory, user: current_user)
        end

        ApiResponse::ValidationError.new(territory.errors)
      end
    end
  end
end
