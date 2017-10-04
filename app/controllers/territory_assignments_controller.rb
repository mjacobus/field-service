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

  def edit
    @territories = TerritoryService.new.search(search_params)
  end

  def update
    payload = params.require(:territory_assignment).permit(:complete)
    assignment = TerritoryAssignment.find(params[:id])

    if assignment.update(payload)
      return head(:ok)
    end

    return head(status: 422)
  end

  def create
    payload = params.require(:assignment).symbolize_keys.merge(
      territory_id: territory.id
    )

    TerritoryAssigning.new.perform(payload)

    redirect_to territory_url(territory), notice: t('territories.assigned')
  rescue
    redirect_to territory_url(territory), alert: t('territories.assignment_error')
  end

  def destroy
    payload = {
      territory_id: territory.id,
      complete: params[:complete],
      returned_at: Date.parse(params[:return_date])
    }

    ReturnTerritory.new.perform(payload)

    redirect_to territory_url(territory.to_param), notice: t('territories.returned')
  end

  private

  def territory
    @_territory ||= Territory.find_by_slug(params[:territory_slug])
  end
end
