# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Endpoints::Householders::SearchEndpoint, type: :endpoint do
  subject { described_class.new(current_user: current_user) }
  describe '#perform' do
    let(:search_string) { 'John str.' }
    let(:perform) { subject.perform(search_string: search_string) }

    it 'returns relevant householders' do
      relevant = double(:relevant)
      query = double(:query)
      allow(query).to receive(:limit).and_return(relevant)
      allow(Householder).to receive(:search).with(search_string).and_return(query)

      response = ApiResponse::Householders::Search.new(relevant)

      expect(perform).to be_equal_to(response)
    end
  end
end
