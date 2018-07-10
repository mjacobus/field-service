# frozen_string_literal: true

module PdfHelper
  def page_break
    '<p style="page-break-after:always;"></p>'.html_safe
  end

  def odd_or_even(index)
    index.even? ? 'even' : 'odd'
  end
end
