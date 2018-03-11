module Endpoints
  module Territories
    class ShowEndpoint < BaseEndpoint
      def perform(slug:)
        handle_errors do
          territory = current_user.territories.find_by_slug(slug)
          ApiResponse::Territories::Show.new(territory, user: current_user)
        end
      end
    end
  end
end
