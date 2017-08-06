require 'test_helper'

class TerritoryAssignmentsControllerTest < ActionDispatch::IntegrationTest
  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end
end
