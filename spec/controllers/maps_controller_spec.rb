require 'rails_helper'

RSpec.describe MapsController, type: :controller do
  before do
    sign_in_as(current_user)
  end

  let(:territory) { Territory.make!(map_coordinates: [{ lat: 1, lng: 1 }]) }

  it 'is a AuthenticatedController' do
    expect(controller).to be_a(AuthenticatedController)
  end

  describe '#show' do
    it 'assigns territory' do
      get :show, params: { territory_slug: territory.to_param }

      expect(assigns(:territory)).to eq(territory)
    end
  end

  describe '#new' do
    it 'assigns territory' do
      get :new, params: { territory_slug: territory.to_param }

      expect(assigns(:territory)).to eq(territory)
    end
  end

  describe '#edit' do
    it 'assigns territory' do
      get :edit, params: { territory_slug: territory.to_param }

      expect(assigns(:territory)).to eq(territory)
    end

    context 'when map is not mapped' do
      it 'redirects to new action' do
        territory.map_coordinates = nil
        territory.save

        get :edit, params: { territory_slug: territory.to_param }

        expect(response).to redirect_to(new_territory_map_path(territory))
      end
    end
  end
end
