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
          householders: territory_householders(territory),
          assigned: current_assignment.present?,
          currentAssignment: current_assignment,
          assignments: assignments(territory)
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
        territory.assignments.map { |assignment| assignment(assignment) }
      end

      def territory_householders(territory)
        territory.householders.map { |householder| householder(householder) }
      end

      def householder(householder)
        {
          id: householder.id,
          name: householder.name,
          streetNname: householder.normalized_street_name,
          address: householder.address,
          visit: householder.visit?,
          show: householder.show?,
          doNotVisitDate: householder.do_not_visit_date,
          geolocation: {
            present: householder.has_geolocation?,
            lat: householder.lat,
            lon: householder.lon
          },
          links: {
            edit: urls.householder_edit_path(householder),
          }
        }
      end

      def assignment(assignment)
        publisher = assignment.publisher

        {
          id: assignment.id,
          territoryId: assignment.territory_id,
          publisherId: assignment.publisher_id,
          complete: assignment.complete,
          pendingReturn: assignment.pending_return?,
          returned: assignment.returned?,
          assignedAt: assignment.assigned_at,
          returnDate: assignment.return_date,
          returnedAt: assignment.returned_at,
          assignee: {
            id: publisher.id,
            name: publisher.name
          }
        }
      end
    end
  end
end
