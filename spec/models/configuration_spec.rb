# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Configuration do
  let(:config) { described_class.create_config_object }

  describe '#update' do
    it 'saves configurations' do
      described_class.update(
        'pdf.font_size' => '',
        'pdf.font_family' => 'Arial'
      )

      expect(config.get('pdf.font_size').value).to eq('12px')
      expect(config.get('pdf.font_family').value).to eq('Arial')
    end
  end
end
