require 'test_helper'

class TerritoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @territory = Territory.make!
  end

  test "should get index" do
    get territories_url
    assert_response :success
  end

  test "should get new" do
    get new_territory_url
    assert_response :success
  end

  test "should create territory" do
    @territory = Territory.make
    assert_difference('Territory.count') do
      post territories_url, params: { territory: { description: @territory.description, name: @territory.name } }
    end

    assert_redirected_to territory_url(Territory.last)
  end

  test "re-renders form on create error" do
    post territories_url, params: { territory: { description: '', name: '' } }
    assert_template 'new'
  end

  test "should show territory" do
    get territory_url(@territory)
    assert_response :success
  end

  test "should get edit" do
    get edit_territory_url(@territory)
    assert_response :success
  end

  test "should update territory" do
    patch territory_url(@territory), params: { territory: { description: @territory.description, name: @territory.name } }
    assert_redirected_to territory_url(@territory)
  end

  test "re-renders form on update error" do
    patch territory_url(@territory), params: { territory: { description: '', name: '' } }
    assert_template 'edit'
  end

  test "should destroy territory" do
    assert_difference('Territory.count', -1) do
      delete territory_url(@territory)
    end

    assert_redirected_to territories_url
  end
end
