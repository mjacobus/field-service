require 'rails_helper'

RSpec.describe TerritoryAssignmentsController do
  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end
end
