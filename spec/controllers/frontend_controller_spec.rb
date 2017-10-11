require 'rails_helper'

RSpec.describe FrontendController, type: :controller do
  describe '#redirect_to_asset' do
    it 'redirects to asset' do
      expected_asset_name = 'foo.bar.gif'

      expect(ActionController::Base.helpers).to receive(:asset_path)
        .with(expected_asset_name).and_return('/foo/bar')

      get :redirect_to_asset, params: { asset: 'foo.bar', format: 'gif' }

      expect(response).to redirect_to('/foo/bar')
    end
  end
end
