# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersController do
  let(:user) { User.make! }
  let(:attribute_names) { %i[name email] }
  let(:payload) { User.make.attributes.symbolize_keys.slice(*attribute_names) }
  let(:changed_attributes) { User.last.attributes.symbolize_keys.slice(*attribute_names) }

  it 'is an authenticated controller' do
    expect(controller).to be_a(AuthenticatedController)
  end

  before do
    sign_in_as_admin
  end

  describe '#index' do
    it 'lists all users' do
      user = User.make!
      users = [user]

      get :index

      expect(response).to be_success
      expect(assigns(:users)).to eq(users)
    end
  end

  describe '#show' do
    it 'assigns user' do
      get :show, params: { id: user.to_param }

      expect(response).to be_success
      expect(assigns(:user)).to eq(user)
    end
  end

  describe '#new' do
    it 'displays new form form' do
      get :new

      expect(response).to be_success
      expect(assigns(:user)).to be_a(User)
      expect(assigns(:user)).not_to be_persisted
    end
  end

  describe '#create' do
    context 'when payload is valid' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: payload }
        end.to change(User, :count).by(1)

        expect(response).to redirect_to('/admin/users')

        expect(changed_attributes).to eq(payload)
      end
    end

    context 'when payload is invalid' do
      it 're renders new form' do
        post :create, params: { user: payload.merge(name: '') }

        expect(response.status).to be(422)
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    it 'displays edit form' do
      get :edit, params: { id: user.to_param }

      expect(response).to be_success
      expect(assigns(:user)).to eq(user)
    end
  end

  describe '#update' do
    context 'when payload is valid' do
      it 'creates a new user' do
        patch :update, params: { id: user.to_param, user: payload }

        expect(response).to redirect_to('/admin/users')

        expect(changed_attributes).to eq(payload)
      end
    end

    context 'when payload is invalid' do
      it 're renders edit form' do
        patch :update, params: { id: user.to_param, user: payload.merge(name: '') }

        expect(response.status).to be(422)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    it 'deletes user' do
      user

      expect do
        delete :destroy, params: { id: user.to_param }
      end.to change(User, :count).by(-1)

      expect(response).to redirect_to('/admin/users')
    end
  end
end
