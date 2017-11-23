require 'rails_helper'

RSpec.describe Api::HouseholdersController, type: :controller do
  describe '#create' do
    it 'delegates to the correct endpoint' do
      householder = {
        street_name: 'street',
        house_number: 'number',
        name: 'name',
        show: 'show',
        do_not_visit_date: 'date'
      }

      expect_controller_to_perform_with(
        territory_slug: 'foo',
        attributes: householder
      )

      post :create, xhr: true, params: { territory_slug: 'foo', householder: householder }

      expect(response).to be_success
    end
  end
end
