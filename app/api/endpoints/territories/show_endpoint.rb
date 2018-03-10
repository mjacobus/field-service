module Endpoints
  module Territories
    class ShowEndpoint < BaseEndpoint
      def perform(slug:)
        territory = current_user.territories.find_by_slug(slug)
        ApiResponse::Territories::Show.new(territory)
      rescue ActiveRecord::RecordNotFound
        ApiResponse::NotFoundResponse.new
      end
    end
  end
end
