require 'test_helper'

class BaseDecoratorTest < ActiveSupport::TestCase
  def subject
    @subject ||= BaseDecorator.new(nil)
  end

  it 'can set helper' do
    helpers = []
    object = subject.with_view_helpers(helpers)

    assert_same helpers, object.send(:view_helpers)
  end
end
