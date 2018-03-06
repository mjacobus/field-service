require 'rails_helper'

class DummyEndpoint < Endpoints::BaseEndpoint
  def user
    current_user
  end
end

RSpec.describe Endpoints::BaseEndpoint do
  let(:user) { double(:user) }
  subject { DummyEndpoint.new(current_user: user) }

  it 'takes an user in the initializer' do
    expect(subject.user).to be(user)
  end
end
