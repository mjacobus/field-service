require 'test_helper'

class TerritoryAssignmentsControllerTest < ActionDispatch::IntegrationTest
  test 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end
end
