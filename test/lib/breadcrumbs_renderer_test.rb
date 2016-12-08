require "test_helper"

class BreadcrumbsRendererTest < TestCase

  def setup
    @view_context = Class.new do
      def link_to(label, url)
        [url, label].join('-')
      end
    end.new

    @renderer = ::BreadcrumbsRenderer.new(@view_context, '>')
  end

  test "can render breadcrumbs properly" do
    expected = 'a1-l1 > a2-l2 > l3'

    actual = @renderer.render([
      ['l1', 'a1'],
      ['l2', 'a2'],
      ['l3'],
    ])

    assert_equal expected, actual
  end
end
