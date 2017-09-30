class TerritoryAssignmentsController < AuthenticatedController
  def index
    @territories = TerritoryService.new.search(search_params)

    respond_to do |format|
      format.html
      format.pdf { export_pdf('territory_assignments', orientation: 'Landscape') }
    end
  end

  def new
    @territory = create_decorator(TerritoryAssignmentDecorator, territory)
  end

  def create
    payload = params.require(:assignment).symbolize_keys

    TerritoryAssigning.new.perform(payload)

    redirect_to territories_url, notice: t('territories.assigned')
  rescue
    territory_id = payload.fetch(:territory_id)
    redirect_to territory_url(territory_id), alert: t('territories.assignment_error')
  end

  def destroy
    payload = {
      territory_id: params[:territory_id],
      complete: params[:complete],
      returned_at: Date.parse(params[:return_date])
    }

    ReturnTerritory.new.perform(payload)

    redirect_to territories_url, notice: t('territories.returned')
  end

  private

  def territory
    @_territory ||= Territory.find(params[:territory_id])
  end
end
