require 'rails_helper'

RSpec.describe Endpoints::Territories::ShowEndpoint, type: :endpoint do
  is_not_admin_endpoint

  let(:territories) { double(:territories) }
  let(:territory) { Territory.new(name: 'foo') }

  before do
    allow(current_user).to receive(:territories).and_return(territories)
  end

  context 'when territory is found' do
    before do
      allow(territories).to receive(:find_by_slug).with('the-slug').and_return(territory)
    end

    it 'returns the user territories when found' do
      response = ApiResponse::Territories::Show.new(territory)

      expect(subject.perform(slug: 'the-slug')).to be_equal_to(response)
    end
  end

  context 'when territory is not found' do
    before do
      allow(territories).to receive(:find_by_slug).with('the-slug') do
        raise ActiveRecord::RecordNotFound, 'Record not found'
      end
    end

    it 'returns the user territories when found' do
      response = ApiResponse::NotFoundResponse.new

      expect(subject.perform(slug: 'the-slug')).to be_equal_to(response)
    end
  end
end
