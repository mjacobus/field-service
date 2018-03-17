require 'rails_helper'

RSpec.describe FrontendController, type: :controller do
  it 'is an AuthenticatedController' do
    expect(controller).to be_a(AuthenticatedController)
  end

  describe '#redirect_to_asset' do
    it 'redirects to asset' do
      sign_in_as(User.new)

      expected_asset_name = 'foo.bar.gif'

      expect(ActionController::Base.helpers).to receive(:asset_path)
        .with(expected_asset_name).and_return('/foo/bar')

      get :redirect_to_asset, params: { asset: 'foo.bar', format: 'gif' }

      expect(response).to redirect_to('/foo/bar')
    end
  end
end
