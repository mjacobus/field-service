require 'test_helper'

class HouseholdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @householder = Householder.make!
  end

  test "should get index" do
    get householders_url
    assert_response :success
  end

  test "should get new" do
    get new_householder_url
    assert_response :success
  end

  test "should create householder" do
    assert_difference('Householder.count') do
      post householders_url, params: { householder: { house_number: @householder.house_number, name: @householder.name, show: @householder.show, street_name: @householder.street_name, territory_id: @householder.territory_id } }
    end

    assert_redirected_to householder_url(Householder.last)
  end

  test "should show householder" do
    get householder_url(@householder)
    assert_response :success
  end

  test "should get edit" do
    get edit_householder_url(@householder)
    assert_response :success
  end

  test "should update householder" do
    patch householder_url(@householder), params: { householder: { house_number: @householder.house_number, name: @householder.name, show: @householder.show, street_name: @householder.street_name, territory_id: @householder.territory_id } }
    assert_redirected_to householder_url(@householder)
  end

  test "should destroy householder" do
    assert_difference('Householder.count', -1) do
      delete householder_url(@householder)
    end

    assert_redirected_to householders_url
  end
end
