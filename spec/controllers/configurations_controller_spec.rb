# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConfigurationsController do
  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  describe 'GET edit' do
    it 'redirects to territories when user is not admin' do
      sign_in_as(current_user)

      get :edit

      expect(response).to redirect_to('/app/territories')
    end

    it 'renders when it is admin' do
      sign_in_as_admin

      get :edit

      expect(response).to be_success
    end
  end
end
