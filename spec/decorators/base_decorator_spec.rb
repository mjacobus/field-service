require 'rails_helper'

RSpec.describe BaseDecorator do
  subject { BaseDecorator.new(nil) }

  it 'can set helper' do
    helpers = []
    object = subject.with_view_helpers(helpers)

    assert_same helpers, object.send(:view_helpers)
  end
end
