module Endpoints
  module Householders
    class CreateEndpoint
      def perform(territory_slug:, attributes:)
        collection = Territory.find_by_slug(territory_slug).householders
        householder = collection.build(attributes)

        if householder.save(attributes)
          return ApiResponse::Householders::Created.new(householder)
        end

        ApiResponse::ValidationError.new(householder.errors)
      end
    end
  end
end
