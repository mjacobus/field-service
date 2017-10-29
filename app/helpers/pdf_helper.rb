module PdfHelper
  def page_break
    '<p style="page-break-after:always;"></p>'.html_safe
  end

  def odd_or_even(index)
    index.even? ? 'even' : 'odd'
  end

  def expand_to(multiple_of, count)
    max = multiple_of
    max *= 2 while max < count

    [].tap do |elements|
      (count + 1).upto(max) do |i|
        elements.push(i)
      end
    end
  end
end
