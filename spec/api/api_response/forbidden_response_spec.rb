require 'rails_helper'

RSpec.describe ApiResponse::ForbiddenResponse do
  it 'responds with 400' do
    expect(subject.status).to be 400
  end

  it 'responds with correct message' do
    expect(subject.to_h).to eq(message: 'Forbidden. Not an admin')
  end
end
