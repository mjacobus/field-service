require 'rails_helper'

RSpec.describe Api::TerritoriesController, type: :controller do
  xspecify '#index delegates to the correct endpoint' do
    expect_controller_to_perform_with(
      assigned_to_ids: [1]
    )

    get :index, params: { assigned_to_ids: [1] }
  end
end
