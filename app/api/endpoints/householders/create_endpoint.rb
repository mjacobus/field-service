module Endpoints
  module Householders
    class CreateEndpoint < BaseEndpoint
      def perform(territory_slug:, attributes:)
        handle_errors do
          collection = current_user.territories.find_by_slug(territory_slug).householders
          householder = collection.build(attributes)

          if householder.save(attributes)
            return ApiResponse::Householders::Created.new(householder)
          end

          ApiResponse::ValidationError.new(householder.errors)
        end
      end
    end
  end
end
