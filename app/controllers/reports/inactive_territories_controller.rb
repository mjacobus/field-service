module Reports
  class InactiveTerritoriesController < ApplicationController
    def index
      if from
        territories = TerritoryService.new(user: current_user).inactive(from: from)
        @territories_decorator = create_decorator(TerritoriesDecorator, territories)
      end
    end

    private

    def from
      @from ||= Date.parse(params[:from]) rescue nil
    end
  end
end
