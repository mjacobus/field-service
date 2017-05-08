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

  test 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  test 'should get index' do
    get @decorator.index_url

    assert_response :success
    assert_equal 1, assigns(:householders_decorator).send(:collection).count
  end

  test 'should get new' do
    get @decorator.new_url

    assert_response :success
  end

  test 'should create householder' do
    assert_difference -> { @territory.householders.count }, 1 do
      post @index_url, params: { territory_id: @territory.id, householder: @householder_params }
    end

    assert_redirected_to resource_url(Householder.last)
    assert_equal t('householders.created'), flash[:notice]
  end

  test 're-render form when create fails' do
    post @index_url, params: { territory_id: @territory.id, householder: @householder_params.merge(name: '') }

    assert_template :new
  end

  test 'should show householder' do
    get @resource_url

    assert_response :success
  end

  test 'should get edit' do
    get @edit_url

    assert_response :success
  end

  test 'should update householder' do
    patch @resource_url, params: { territory_id: @territory.id, householder: @householder_params }

    assert_redirected_to @resource_url
    assert_equal t('householders.updated'), flash[:notice]
  end

  test 're-render form when update fails' do
    patch @resource_url, params: { territory_id: @territory.id, householder: @householder_params.merge(name: '') }

    assert_template :edit
  end

  test 'should destroy householder' do
    assert_difference -> { @territory.householders.count }, -1 do
      delete @decorator.url
    end

    assert_redirected_to @decorator.index_url
    assert_equal t('householders.destroyed'), flash[:notice]
  end
end
