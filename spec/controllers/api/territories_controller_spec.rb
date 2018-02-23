require 'rails_helper'

RSpec.describe Api::TerritoriesController, type: :controller do
  describe '#index' do
    it 'delegates to the correct endpoint' do
      expect_controller_to_perform_with(assigned_to_ids: ['1'])

      get :index, xhr: true, params: { assigned_to_ids: [1] }
      expect(response).to be_success
    end
  end

  describe '#show' do
    it 'delegates to the correct endpoint' do
      expect_controller_to_perform_with(slug: 'foo')

      get :show, xhr: true, params: { slug: 'foo' }
      expect(response).to be_success
    end
  end

  describe '#update' do
    it 'delegates to the correct endpoint' do
      unnormalized_coordinates = { '1' => { 'lat' => '1.2', 'lng' => '2.1' } }

      territory = {
        name: 'the-name',
        description: 'the-description',
        city: 'the-city',
        responsible_id: 'the-responsible',
        map_coordinates: unnormalized_coordinates
      }

      expect_controller_to_perform_with(
        slug: 'foo',
        attributes: territory
      )

      put :update, xhr: true, params: {
        slug: 'foo',
        territory: territory.merge(other: true)
      }

      expect(response).to be_success
    end

    it 'can be used to delete mapped coordinates' do
      sign_in_as(current_user)

      territory = Territory.make!(map_coordinates: [{ foo: :bar }])

      put :update, xhr: true, params: {
        slug: territory.to_param,
        territory: { map_coordinates: '' }
      }

      expect(Territory.last).not_to be_mapped
    end
  end
end
