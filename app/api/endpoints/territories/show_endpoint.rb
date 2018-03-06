module Endpoints
  module Territories
    class ShowEndpoint < AdminEndpoint
      private

      def perform_as_admin(slug:)
        territory = Territory.find_by_slug(slug)
        ApiResponse::Territories::Show.new(territory)
      end
    end
  end
end
