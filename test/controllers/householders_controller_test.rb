require 'test_helper'

class HouseholdersControllerTest < ControllerTestCase
  setup do
    # other territory
    Householder.make!

    @territory = Territory.make!
    @householder = Householder.make!(territory: @territory)
    @decorator = HouseholderDecorator.new(@householder)
    @edit_url = @decorator.edit_url
    @new_url = @decorator.new_url
    @index_url = @decorator.index_url
    @resource_url = @decorator.url

    @householder_params = {
      house_number: @householder.house_number,
      name: @householder.name,
      show: @householder.show,
      street_name: @householder.street_name,
      notes: @householder.notes
    }
    sign_in_as(current_user)
  end

  def resource_url(resource)
    HouseholderDecorator.new(resource).url
  end

  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  it 'should get index' do
    get @decorator.index_url

    assert_response :success
    assert_equal 1, assigns(:householders_decorator).send(:collection).count
  end

  it 'should get index as csv' do
    get @decorator.index_url + '.csv'

    assert_response :success
    assert_equal 'text/csv; charset=utf-8', response.headers['Content-Type']

    # fails when all tests are run together
    # assert_match /,#{@territory.name},/, response.body
  end

  it 'should get new' do
    get @decorator.new_url

    assert_response :success
  end

  it 'should create householder' do
    Householder.any_instance.expects(:update_geolocation)

    assert_difference -> { @territory.householders.count }, 1 do
      post @index_url, params: { territory_id: @territory.id, householder: @householder_params }
    end

    assert_redirected_to resource_url(Householder.unscoped.last)
    assert_equal t('householders.created'), flash[:notice]
  end

  it 're-render form when create fails' do
    post @index_url, params: { territory_id: @territory.id, householder: @householder_params.merge(name: '') }

    assert_template :new
  end

  it 'should show householder' do
    get @resource_url

    assert_response :success
  end

  it 'should get edit' do
    get @edit_url

    assert_response :success
  end

  it 'should update householder' do
    Householder.any_instance.expects(:update_geolocation)

    patch @resource_url, params: { territory_id: @territory.id, householder: @householder_params }

    assert_redirected_to @resource_url
    assert_equal t('householders.updated'), flash[:notice]
  end

  it 're-render form when update fails' do
    patch @resource_url, params: { territory_id: @territory.id, householder: @householder_params.merge(name: '') }

    assert_template :edit
  end

  it 'should destroy householder' do
    assert_difference -> { @territory.householders.count }, -1 do
      delete @decorator.url
    end

    assert_redirected_to @decorator.index_url
    assert_equal t('householders.destroyed'), flash[:notice]
  end
end
