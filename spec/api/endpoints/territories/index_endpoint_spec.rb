require 'rails_helper'

RSpec.describe Endpoints::Territories::IndexEndpoint, type: :endpoint do
  let(:service) { instance_double(TerritoryService) }
  let(:territories) { [Territory.new] }
  let(:params) { { assigned_to_ids: :bar } }

  before do
    allow(TerritoryService).to receive(:new).with(user: current_user) { service }
    allow(service).to receive(:search).with(params).and_return(territories)
  end

  describe '#perform' do
    it 'returns a response for the given user' do
      response = subject.perform(params)

      expected_response = ApiResponse::Territories::Index.new(
        territories,
        user: current_user
      )

      expect(response).to be_equal_to(expected_response)
    end
  end
end
