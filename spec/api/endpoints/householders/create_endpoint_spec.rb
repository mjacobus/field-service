require 'rails_helper'

RSpec.describe Endpoints::Householders::CreateEndpoint, type: :endpoint do
  is_not_admin_endpoint

  let(:attributes) { { some: :attributes } }

  describe '#perform' do
    context 'when territory is not found' do
      it 'responds with not found' do
        response = subject.perform(territory_slug: 'the-slug', attributes: attributes)

        expect(response).to be_equal_to(ApiResponse::NotFoundResponse.new)
      end
    end

    context 'when territory is found' do
      let(:territories) { class_double(Territory) }
      let(:territory) { Territory.make!(name: 'the name') }
      let(:perform) { subject.perform(territory_slug: 'the-name', attributes: attributes) }

      before do
        expect(current_user).to receive(:territories).and_return(territories)
        expect(territories).to receive(:find_by_slug).with('the-name').and_return(territory)
      end

      context 'with valid payload' do
        let(:attributes) do
          {
            name: 'the-name',
            show: true,
            street_name: 'the street name',
            house_number: 'the house number'
          }
        end

        it 'creates a new housholder' do
          expect { perform }.to change { territory.householders.count }.by(1)

          expected_resonse = ApiResponse::Householders::Created.new(Householder.last)

          expect(perform).to be_equal_to(expected_resonse)
        end
      end

      context 'with invalid payload' do
        let(:attributes) { { name: 'the-name' } }

        it 'creates a new housholder' do
          expect(perform).to be_a(ApiResponse::ValidationError)
        end
      end
    end
  end
end
