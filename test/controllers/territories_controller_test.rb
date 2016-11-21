require 'test_helper'

class TerritoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @territory = Territory.make!
    @decorator = TerritoryDecorator.new(@territory)
    @edit_url = @decorator.edit_url
    @new_url = @decorator.new_url
    @index_url = @decorator.index_url
    @resource_url = @decorator.url

    @territory_params = { description: @territory.description, name: @territory.name }
  end

  def resource_url(resource = @resource)
    TerritoryDecorator.new(resource).url
  end

  test "should get index" do
    get @index_url

    assert_response :success
  end

  test "should get new" do
    get @new_url

    assert_response :success
  end

  test "should create territory" do
    @territory = Territory.make

    assert_difference('Territory.count') do
      post @index_url, params: { territory: @territory_params.merge(name: @territory.name) }
    end

    assert_redirected_to resource_url(Territory.last)
  end

  test "re-renders form on create error" do
    post @index_url, params: { territory: @territory_params.merge(name: '') }

    assert_template 'new'
  end

  test "should show territory" do
    get @resource_url

    assert_response :success
  end

  test "should get edit" do
    get @edit_url

    assert_response :success
  end

  test "should update territory" do
    patch @resource_url, params: { territory: @territory_params }

    assert_redirected_to @resource_url
  end

  test "re-renders form on update error" do
    patch @resource_url, params: { territory: @territory_params.merge(name: '') }

    assert_template 'edit'
  end

  test "should destroy territory" do
    assert_difference('Territory.count', -1) do
      delete @resource_url
    end

    assert_redirected_to @index_url
  end
end
