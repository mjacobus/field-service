module ApiResponse
  module Householders
    class Show < Show
      def initialize(householder)
        @householder = householder
      end

      def to_h
        { data: @householder.attributes.to_h }
      end
    end
  end
end

