require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { User.make }

  before do
    sign_in_as(user)
  end

  it 'is authenticated controller' do
    expect(subject).to be_a(AuthenticatedController)
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit

      expect(response).to have_http_status(:success)

      expect(assigns(:user)).to be(user)
    end
  end

  describe 'PATCH #update' do
    before do
      user.password = 'oldpwd'
      user.save!
    end

    let(:valid_attributes) do
      {
        email: 'the@new.email',
        password: 'oldpwd',
        new_password: 'newpwd'
      }
    end

    let(:perform_request) { patch :update, params: { user: attributes } }

    context 'with valid attribtes' do
      let(:attributes) { valid_attributes }

      it 'redirects to territories path' do
        perform_request

        expect(response).to redirect_to('/territories')
      end

      it 'changes email' do
        expect { perform_request }.to change { User.last.email }.to(valid_attributes[:email])
      end

      it 'changes password' do
        perform_request

        expect(User.last.authenticated?(valid_attributes[:new_password])).to be true
      end
    end

    context 'with email only' do
      let(:attributes) { valid_attributes.merge(password: '', new_password: '') }

      it 'changes only email' do
        expect { perform_request }.to change { User.last.email }.to(valid_attributes[:email])
      end

      it 'does not change password' do
        perform_request

        expect(User.last.authenticated?(valid_attributes[:password])).to be true
      end
    end

    context 'with invalid passord' do
      let(:attributes) { valid_attributes.merge(password: 'old', new_password: 'new') }

      it 're renders edit' do
        perform_request

        expect(subject).to render_template(:edit)
        expect(response).to be_success
      end
    end
  end
end
