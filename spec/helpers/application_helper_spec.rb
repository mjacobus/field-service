require 'rails_helper'

RSpec.describe ApplicationHelper do
  it '#breadcrumbs generates breadcumbs' do
    skip 'check this thingy'

    expected = [
      '<a href="a1">l1</a> &gt; ',
      '<a href="a2">l2</a> &gt; ',
      'l3'
    ].join('')

    actual = render([
                      %w[l1 a1],
                      %w[l2 a2],
                      ['l3']
                    ])

    assert_equal expected, actual
  end
end
