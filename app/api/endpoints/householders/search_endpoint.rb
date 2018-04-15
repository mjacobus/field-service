# frozen_string_literal: true

module Endpoints
  module Householders
    class SearchEndpoint < BaseEndpoint
      def perform(search_string:)
        handle_errors do
          relevant = Householder.search(search_string).limit(100)
          ApiResponse::Householders::Search.new(relevant)
        end
      end
    end
  end
end
