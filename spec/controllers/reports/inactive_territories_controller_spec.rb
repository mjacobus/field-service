require 'rails_helper'

RSpec.describe Reports::InactiveTerritoriesController, type: :controller do
  describe '#index' do
    let(:service) { double(TerritoryService)  }

    before do
      allow(TerritoryService).to receive(:new) { service }
      allow(service).to receive(:inactive) { [] }
    end

    it 'calls service with correct date' do
      get :index, params: { from: '2001-02-03' }

      expect(service).to have_received(:inactive) do |params|
        expect(params[:from]).to eq(Date.new(2001, 2, 3))
      end
    end

    it 'does not call when there is no date' do
      get :index

      expect(service).not_to have_received(:inactive)
    end
  end
end
