require 'rails_helper'

RSpec.describe PdfHelper do
  describe '#odd_or_even' do
    it 'returns "even" when even and "odd" when odd' do
      expect(helper.odd_or_even(1)).to eq('odd')
      expect(helper.odd_or_even(3)).to eq('odd')
      expect(helper.odd_or_even(5)).to eq('odd')

      expect(helper.odd_or_even(0)).to eq('even')
      expect(helper.odd_or_even(2)).to eq('even')
      expect(helper.odd_or_even(4)).to eq('even')
      expect(helper.odd_or_even(6)).to eq('even')
    end
  end
end
