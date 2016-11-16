require "test_helper"

class ViewObjectTest < ActiveSupport::TestCase

  def subject
    @subject ||= ViewObject.new
  end

  test "can set helper" do
    helpers = []
    object = subject.with_view_helpers(helpers)

    assert_same helpers, object.send(:view_helpers)
  end
end
