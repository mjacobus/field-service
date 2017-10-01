require 'rails_helper'

RSpec.describe TerritoryAssignmentsController do
  before do
    sign_in_as(User.new)
  end

  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  let(:last_assignment) { TerritoryAssignment.last }

  describe '#create' do
    let(:territory) { Territory.make! }
    let(:publisher) { Publisher.make! }

    let(:perform_request) do
      request_params = {
        territory_id: territory.id,
        publisher_id: publisher.id,
      }

      post :create, params: { territory_id: territory.id, assignment: request_params }
    end

    it 'marks territory as returned' do
      perform_request

      expect(last_assignment).not_to be_returned
      expect(last_assignment).not_to be_complete
      expect(last_assignment.publisher_id).to eq publisher.id
      expect(last_assignment.territory_id).to eq territory.id
    end

    it 'redirects to the territory url' do
      perform_request

      expect(response).to redirect_to(territory_url(territory.id))
    end
  end

  describe '#destroy' do
    let(:territory) { TerritoryAssignment.make!.territory }

    let(:perform_request) do
      request_params = {
        territory_id: territory.id,
        return_date: '2001-02-03',
        complete: 1,
        id: 'none'
      }

      delete :destroy, params: request_params
    end

    let(:last_assignment) { TerritoryAssignment.last }

    it 'marks territory as returned' do
      perform_request

      expect(last_assignment).to be_returned
      expect(last_assignment).to be_complete
      expect(last_assignment.returned_at).to eq Date.new(2001, 2, 3)
    end

    it 'redirects to the territory url' do
      perform_request

      expect(response).to redirect_to(territory_url(territory.id))
    end
  end
end
