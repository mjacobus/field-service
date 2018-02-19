require 'rails_helper'

RSpec.describe MapsController, type: :controller do
  it 'is a AuthenticatedController' do
    expect(controller).to be_a(AuthenticatedController)
  end
end
