# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AppConfig do
  let(:config) { subject }
  let(:hash) { config.to_h }

  describe '#get' do
    it 'raises an error when key is not found' do
      expect { config.get('unexisting') }.to raise_error(
        ArgumentError,
        "invalid key 'unexisting'"
      )
    end
  end

  describe '#set' do
    it 'set config to semthing else' do
      config.set('pdf.font_size', 'something_else')

      value = config.get('pdf.font_size').value

      expect(value).to eq('something_else')
    end
  end

  describe 'pdf' do
    describe '.font_size' do
      it 'has a proper default value' do
        value = config.get('pdf.font_size').value

        expect(value).to eq('12px')
      end
    end

    describe '.font_family' do
      it 'has a proper default value' do
        value = config.get('pdf.font_family').value

        expect(value).to eq("Verdana, Arial, 'OpenSansRegular'")
      end
    end
  end
end
