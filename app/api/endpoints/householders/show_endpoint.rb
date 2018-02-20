module Endpoints
  module Householders
    class ShowEndpoint
      def perform(territory_slug:, id:)
        householder = Territory.find_by_slug(territory_slug).householders.find(id)
        ApiResponse::Householders::Show.new(householder)
      end
    end
  end
end
