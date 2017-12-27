require 'rails_helper'

RSpec.describe AuthenticatedController, type: :controller do
  describe 'as a logged out user' do
    it 'requires logged in' do
      get :test

      expect(response.status).to be 302
      expect(response).to redirect_to('/sign_in')
    end
  end

  describe 'as a logged in as' do
    describe 'a regular user' do
      it 'requires loggin' do
        sign_in_as(User.new)

        get :test

        expect(response.status).to be 302
        expect(response).to redirect_to('/sign_in')
      end
    end

    describe 'admin' do
      it 'returns resource' do
        sign_in_as(User.new(admin: true))

        get :test

        expect(response.status).to be 200
        expect(response.body).to eq('ok')
      end
    end
  end
end
