require 'rails_helper'

RSpec.describe PublishersController do
  let(:current_user) { User.new(admin: true) }

  before do
    @publisher = Publisher.make!
    @decorator = PublisherDecorator.new(@publisher)
    @edit_url = @decorator.edit_url
    @new_url = @decorator.new_url
    @index_url = @decorator.index_url
    @resource_url = @decorator.url

    @publisher_params = {
      name: @publisher.name,
      email: @publisher.email,
      phone: @publisher.phone,
      congregation_member: 1
    }
    sign_in_as(current_user)
  end

  def resource_url(resource = @resource)
    PublisherDecorator.new(resource).url
  end

  it 'is authenticated controller' do
    assert subject.is_a?(AuthenticatedController)
  end

  it 'should get index' do
    get :index, params: { id: @publisher.id }

    assert_response :success
  end

  it 'should get new' do
    get :new

    assert_response :success
  end

  it 'should create publisher' do
    params = {
      publisher: { email: @publisher.email, name: @publisher.name, phone: @publisher.phone }
    }

    expect do
      post :create, params: params
    end.to change { Publisher.count }.by(1)

    assert_redirected_to publisher_url(Publisher.last)
  end

  it 'should show publisher' do
    get :show, params: { id: @publisher.id }

    assert_response :success
  end

  it 'should get edit' do
    get :edit, params: { id: @publisher.id }

    assert_response :success
  end

  it 'should update publisher' do
    params = {
      id: @publisher.id,
      publisher: { email: @publisher.email, name: @publisher.name, phone: @publisher.phone }
    }

    patch :update, params: params

    assert_redirected_to @resource_url
  end

  it 'should destroy publisher' do
    expect do
      delete :destroy, params: { id: @publisher.id }
    end.to change { Publisher.count }.by(-1)

    assert_redirected_to @index_url
  end
end
