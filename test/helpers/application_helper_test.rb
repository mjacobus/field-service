require "test_helper"

class ApplicationHelperTest < HelperTestCase
  test "#breadcrumbs generates breadcumbs" do
    skip "check this thingy"

    expected = [
      '<a href="a1">l1</a> &gt; ',
      '<a href="a2">l2</a> &gt; ',
      'l3'
    ].join('')

    actual = render([
      ['l1', 'a1'],
      ['l2', 'a2'],
      ['l3'],
    ])

    assert_equal expected, actual
  end
end
