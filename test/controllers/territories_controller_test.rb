require 'test_helper'

class TerritoriesControllerTest < ControllerTestCase
  setup do
    @territory = Territory.make!
    @decorator = TerritoryDecorator.new(@territory)
    @edit_url = @decorator.edit_url
    @new_url = @decorator.new_url
    @index_url = @decorator.index_url
    @resource_url = @decorator.url

    @territory_params = { description: @territory.description, name: @territory.name }
    sign_in_as(current_user)
  end

  def resource_url(resource = @resource)
    TerritoryDecorator.new(resource).url
  end

  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  it 'should get index' do
    get @index_url

    assert_response :success
  end

  it 'should get new' do
    get @new_url

    assert_response :success
  end

  it 'should create territory' do
    @territory = Territory.make

    assert_difference('Territory.count') do
      post @index_url, params: { territory: @territory_params.merge(name: @territory.name) }
    end

    assert_redirected_to resource_url(Territory.last)
    assert_equal t('territories.created'), flash[:notice]
  end

  it 're-renders form on create error' do
    post @index_url, params: { territory: @territory_params.merge(name: '') }

    assert_template 'new'
  end

  it 'should show territory' do
    get @resource_url

    assert_response :success
  end

  it 'should get edit' do
    get @edit_url

    assert_response :success
  end

  it 'should update territory' do
    patch @resource_url, params: { territory: @territory_params }

    assert_redirected_to @resource_url
    assert_equal t('territories.updated'), flash[:notice]
  end

  it 're-renders form on update error' do
    patch @resource_url, params: { territory: @territory_params.merge(name: '') }

    assert_template 'edit'
  end

  it 'should destroy territory' do
    assert_difference('Territory.count', -1) do
      delete @resource_url
    end

    assert_redirected_to @index_url
    assert_equal t('territories.destroyed'), flash[:notice]
  end

  it 'displays error when cannot destroy a territory' do
    Householder.make!(territory: @territory)

    delete @resource_url

    assert_equal t('territories.cannot_destroy'), flash[:alert]
    assert_redirected_to @index_url
  end
end
