require 'rails_helper'

class DummyAdminEndpoint < Endpoints::AdminEndpoint
  private

  def perform_as_admin(*args)
    args
  end
end

RSpec.describe Endpoints::AdminEndpoint, type: :endpoint do
  subject { DummyAdminEndpoint.new(current_user: current_user) }

  describe 'perform' do
    context 'as non admin' do
      let(:current_user) { User.new(admin: false) }

      it 'returns with a forbidden answer when user is not an admin' do
        expect(subject.perform).to be_a(ApiResponse::ForbiddenResponse)
      end
    end

    context 'as non admin' do
      let(:current_user) { User.new(admin: true) }

      it 'returns the response from #perform_as_admin method' do
        expect(subject.perform(1, 2)).to eq([1, 2])
      end
    end
  end
end
