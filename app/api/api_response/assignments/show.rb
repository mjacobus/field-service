module ApiResponse
  module Assignments
    class Show < BaseResponse
      def initialize(assignment)
        @assignment = assignment
        @publisher = assignment.publisher
      end

      def to_h
        {
          data: {
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
        }
      end

      private

      attr_reader :assignment
      attr_reader :publisher
    end
  end
end
