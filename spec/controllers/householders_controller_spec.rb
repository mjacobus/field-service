require 'rails_helper'

RSpec.describe HouseholdersController, type: :controller do
  let(:current_user) { User.make!(password: 'admin') }
  let(:territory) { Territory.make! }
  let(:householder) { Householder.make!(territory: territory) }
  let(:decorator) { HouseholderDecorator.new(householder) }

  let(:householder_params) do
    {
      house_number: householder.house_number,
      name: householder.name,
      show: householder.show,
      street_name: householder.street_name,
      do_not_visit_date: '2001-02-03',
      notes: householder.notes
    }
  end

  before do
    # other territory
    Householder.make!

    householder

    sign_in_as(current_user)
  end

  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  it 'should get index' do
    Householder.where(territory_id: territory.id).count

    get :index, params: { territory_slug: territory.to_param }

    assert_response :success
    assert_equal 1, assigns(:householders_decorator).send(:collection).count
  end

  it 'should get index as csv' do
    get :index, params: { territory_slug: territory.to_param, format: :csv }

    assert_response :success
    assert_equal 'text/csv; charset=utf-8', response.headers['Content-Type']

    # fails when all tests are run together
    assert_match(/,#{territory.name},/, response.body)
  end

  it 'should get new' do
    get :new, params: { territory_slug: territory.to_param }

    assert_response :success
  end

  it 'should create householder' do
    expect_any_instance_of(Householder).to receive(:update_geolocation)

    expect do
      post :create, params: { territory_slug: territory.to_param }.merge(householder: householder_params)
    end.to change { territory.householders.count }.by(1)

    index = HouseholderDecorator.new(Householder.unscoped.last).index_url

    assert_redirected_to index
    assert_equal t('householders.created'), flash[:notice]
  end

  it 're-render form when create fails' do
    params = { territory_slug: territory.to_param }.merge(householder: householder_params.merge(name: ''))

    post :create, params: params

    assert_template :new
  end

  it 'should show householder' do
    get :show, params: { territory_slug: territory.to_param, id: householder.id }

    assert_response :success
  end

  it 'should get edit' do
    get :edit, params: { territory_slug: territory.to_param, id: householder.id }

    assert_response :success
  end

  it 'should update householder' do
    expect_any_instance_of(Householder).to receive(:update_geolocation)

    params = { territory_slug: territory.to_param, id: householder.id, householder: householder_params }

    patch :update, params: params

    assert_redirected_to "/app/territories/#{householder.territory.to_param}"
  end

  it 're-render form when update fails' do
    params = {
      territory_slug: territory.to_param,
      id: householder.id,
      householder: householder_params.merge(name: '')
    }

    patch :update, params: params

    assert_template :edit
  end

  it 'should destroy householder' do
    expect do
      delete :destroy, params: { territory_slug: territory.to_param, id: householder.id }
    end.to change { Householder.count }.by(-1)

    assert_redirected_to decorator.index_url
    assert_equal t('householders.destroyed'), flash[:notice]
  end
end
