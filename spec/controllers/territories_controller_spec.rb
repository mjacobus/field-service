require 'rails_helper'

RSpec.describe TerritoriesController do
  let(:current_user) { User.make! }
  before do
    @territory = Territory.make!
    @decorator = TerritoryDecorator.new(@territory)
    @edit_url = @decorator.edit_url
    @new_url = @decorator.new_url
    @index_url = @decorator.index_url
    @resource_url = @decorator.url

    @territory_params = {
      description: @territory.description,
      name: @territory.name,
      city: 'Novo Hamburgo'
    }

    sign_in_as(current_user)
  end

  def resource_url(resource = @resource)
    TerritoryDecorator.new(resource).url
  end

  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  it 'should get index' do
    get :index

    assert_response :success
  end

  it 'should get new' do
    get :new

    assert_response :success
  end

  it 'should create territory' do
    @territory = Territory.make

    expect do
      post :create, params: { territory: @territory_params.merge(name: @territory.name) }
    end.to change { Territory.count }.by(1)

    assert_redirected_to resource_url(Territory.last)
    assert_equal t('territories.created'), flash[:notice]
  end

  it 're-renders form on create error' do
    post :create, params: { territory: @territory_params.merge(name: '') }

    assert_template 'new'
  end

  it 'should show territory' do
    get :show, params: { slug: @territory.to_param }

    assert_response :success
  end

  it 'should get edit' do
    get :edit, params: { slug: @territory.to_param }

    assert_response :success
  end

  it 'should update territory' do
    patch :update, params: { slug: @territory.to_param, territory: @territory_params }

    assert_redirected_to @resource_url
    assert_equal t('territories.updated'), flash[:notice]
  end

  it 're-renders form on update error' do
    patch :update, params: { slug: @territory.to_param, territory: @territory_params.merge(name: '') }

    assert_template 'edit'
  end

  it 'should destroy territory' do
    expect do
      delete :destroy, params: { slug: @territory.to_param }
    end.to change { Territory.count }.by(-1)

    assert_redirected_to @index_url
    assert_equal t('territories.destroyed'), flash[:notice]
  end

  it 'displays error when cannot destroy a territory' do
    Householder.make!(territory: @territory)

    expect do
      delete :destroy, params: { slug: @territory.to_param }
    end.not_to change { Territory.count }

    assert_equal t('territories.cannot_destroy'), flash[:alert]
    assert_redirected_to @index_url
  end
end
