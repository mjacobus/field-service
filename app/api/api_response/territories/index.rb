module ApiResponse
  module Territories
    class Index
      def initialize(territories)
        @territories = territories
      end

      def to_h
        data = [].tap do |collection|
          @territories.each do |territory|
            collection << territory_to_hash(territory)
          end
        end

        { data: data }
      end

      private

      def territory_to_hash(territory)
        {
          id: territory.id,
          slug: territory.slug,
          name: territory.name,
          city: territory.city,
          description: territory.description,
          householders: territory_householders(territory),
          currentAssignment: territory_assignment(territory),
        }
      end

      def territory_assignment(territory)
        assignment = territory.current_assignment
        return nil unless assignment

        {
          assigneeId: assignment.publisher_id,
          assigneeName: assignment.publisher.name,
          returnDate: assignment.return_date,
          pendingReturn: assignment.pending_return?
        }
      end

      def territory_householders(territory)
        territory.householders.map(&:id)
      end
    end
  end
end
