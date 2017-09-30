require 'rails_helper'

RSpec.describe TerritoryAssignmentsController do
  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  describe '#destroy' do
    let(:perform_request) do
      sign_in_as(User.new)
      territory = TerritoryAssignment.make!.territory

      request_params = {
        territory_id: territory.id,
        return_date: '2001-02-03',
        complete: 1,
        id: 'none'
      }

      delete :destroy, params: request_params
    end

    let(:assignment) { TerritoryAssignment.last }

    it 'marks territory as returned' do
      perform_request

      expect(assignment).to be_returned
      expect(assignment).to be_complete
      expect(assignment.returned_at).to eq Date.new(2001, 2, 3)
    end

    it 'redirects to territories url' do
      perform_request

      expect(response).to redirect_to(territories_url)
    end
  end
end
