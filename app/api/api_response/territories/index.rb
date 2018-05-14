# frozen_string_literal: true

module ApiResponse
  module Territories
    class Index < BaseResponse
      def initialize(territories, user:)
        @territories = territories
        @user = user
      end

      def to_h
        data = [].tap do |collection|
          @territories.each do |territory|
            collection << territory_to_hash(territory)
          end
        end

        { count: data.count, links: links, data: data }
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
          responsible: responsible(territory)
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
        territory.householders.select(:id).map { |h| h[:id] }
      end

      def responsible(territory)
        return nil unless territory.responsible

        {
          id: territory.responsible.id,
          name: territory.responsible.name
        }
      end

      def links
        unless @user.admin?
          return {}
        end

        {
          newTerritory: urls.new_territory_url
        }
      end
    end
  end
end
