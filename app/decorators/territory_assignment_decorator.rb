class TerritoryAssignmentDecorator < ActiveRecordModelDecorator
  def candidates
    @candidates ||= Publisher.search(search: params[:q])
  end

  def assignments_url
    "/territories/#{id}/assignments"
  end

  def search_url
    "/territories/#{id}/assignments/new?q={#{encode(search_term)}}"
  end

  def search_term
    params[:q]
  end

  def assignment_confirmation_message(publisher)
    t('confirm_assignment_for_publisher', publisher: publisher.name)
  end
end
