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

  describe '#expand_to' do
    it 'expands to the next multiple of :multiple_of' do
      expect(expand_to(40, 32)).to eq((33..40).to_a)
      expect(expand_to(40, 64)).to eq((65..80).to_a)
      expect(expand_to(40, 1)).to eq((2..40).to_a)
      expect(expand_to(40, 39)).to eq([40])
      expect(expand_to(40, 40)).to eq([])
    end
  end
end
