module Endpoints
  module Territories
    class ShowEndpoint
      def perform(slug:)
        territory = Territory.find_by_slug(slug)
        ApiResponse::Territories::Show.new(territory)
      end
    end
  end
end
