require 'test_helper'

class HouseholdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @householder = Householder.make!
    @decorator = Householders::ItemView.new(@householder)
    @edit_url = @decorator.edit_url
    @new_url = @decorator.new_url
    @index_url = @decorator.index_url
    @resource_url = @decorator.url

    @householder_params = {
      house_number: @householder.house_number,
      name: @householder.name,
      show: @householder.show,
      street_name: @householder.street_name,
      territory_id: @householder.territory_id
    }
  end

  def resource_url(resource)
    Householders::ItemView.new(resource).url
  end

  test "should get index" do
    get @decorator.index_url

    assert_response :success
  end

  test "should get new" do
    get @decorator.new_url

    assert_response :success
  end

  test "should create householder" do
    assert_difference('Householder.count') do
      post @index_url, params: { householder: @householder_params }
    end

    assert_redirected_to resource_url(Householder.last)
  end

  test "re-render form when create fails" do
    post @index_url, params: { householder: @householder_params.merge(name: '') }

    assert_template :new
  end

  test "should show householder" do
    get @resource_url

    assert_response :success
  end

  test "should get edit" do
    get @resource_url

    assert_response :success
  end

  test "should update householder" do
    patch @resource_url, params: { householder: @householder_params }

    assert_redirected_to @resource_url
  end

  test "re-render form when update fails" do
    patch @resource_url, params: { householder: @householder_params.merge(name: '') }

    assert_template :edit
  end

  test "should destroy householder" do
    assert_difference('Householder.count', -1) do
      delete @decorator.url
    end

    assert_redirected_to @decorator.index_url
  end
end
