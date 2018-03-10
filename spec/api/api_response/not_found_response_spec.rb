require 'rails_helper'

RSpec.describe ApiResponse::NotFoundResponse do
  it 'responds with 400' do
    expect(subject.status).to be 404
  end

  it 'responds with correct message' do
    expect(subject.to_h).to eq(message: 'Not found')
  end
end

