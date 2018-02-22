module ApiResponse
  module Territories
    class Show < BaseResponse
      def initialize(territory)
        @territory = territory
      end

      def to_h
        { data: territory(@territory) }
      end

      private

      def territory(territory)
        current_assignment = territory_assignment(territory)

        {
          id: territory.id,
          slug: territory.slug,
          name: territory.name,
          city: territory.city,
          description: territory.description,
          assigned: current_assignment.present?,
          currentAssignment: current_assignment,
          links: links(territory),
          assignments: assignments(territory),
          householders: territory_householders(territory),
          map: territory.map.to_h
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

      def assignments(territory)
        territory.assignments.map do |assignment|
          Assignments::Show.new(assignment).to_h[:data]
        end
      end

      def territory_householders(territory)
        territory.householders.map do |householder|
          Householders::Show.new(householder).to_h[:data]
        end
      end

      def links(territory)
        values = {}

        if territory.assigned?
          values[:return] = urls.territory_return_path(territory)
        end

        unless territory.assigned?
          values[:assign] = urls.territory_assign_path(territory)
        end

        values
      end
    end
  end
end
