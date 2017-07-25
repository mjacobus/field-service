require 'test_helper'

class PublishersControllerTest < ControllerTestCase
  setup do
    @publisher = Publisher.make!
    @decorator = PublisherDecorator.new(@publisher)
    @edit_url = @decorator.edit_url
    @new_url = @decorator.new_url
    @index_url = @decorator.index_url
    @resource_url = @decorator.url

    @publisher_params = { name: @publisher.name, email: @publisher.email, phone: @publisher.phone }
    sign_in_as(current_user)
  end

  def resource_url(resource = @resource)
    PublisherDecorator.new(resource).url
  end

  test 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  test 'should get index' do
    get @index_url
    assert_response :success
  end

  test 'should get new' do
    get @new_url
    assert_response :success
  end

  test 'should create publisher' do
    assert_difference('Publisher.count') do
      post @index_url, params: { publisher: { email: @publisher.email, name: @publisher.name, phone: @publisher.phone } }
    end

    assert_redirected_to publisher_url(Publisher.last)
  end

  test 'should show publisher' do
    get @resource_url
    assert_response :success
  end

  test 'should get edit' do
    get @edit_url
    assert_response :success
  end

  test 'should update publisher' do
    patch @resource_url, params: { publisher: { email: @publisher.email, name: @publisher.name, phone: @publisher.phone } }
    assert_redirected_to @resource_url
  end

  test 'should destroy publisher' do
    assert_difference('Publisher.count', -1) do
      delete @resource_url
    end

    assert_redirected_to @index_url
  end
end
