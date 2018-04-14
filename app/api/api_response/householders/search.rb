# frozen_string_literal: true

module ApiResponse
  module Householders
    class Search < ApiResponse::BaseResponse
      def initialize(householders)
        @householders = householders
      end

      def to_h
        {
          data: @householders.map do |householder|
            householder_entry(householder)
          end
        }
      end

      def status
        200
      end

      private

      def householder_entry(householder)
        data = ApiResponse::Householders::Show.new(householder).to_h[:data]
        data[:territory_name] = householder.territory_name
        data[:links][:territory] = urls.territory_path(householder.territory)
        data
      end

    end
  end
end
