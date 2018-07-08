# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AppConfig::Item do
  let(:item) { described_class.new('emails.reply_to', default_value: 'xyz') }

  describe '#value' do
    it 'returns default_value value when nothing is set' do
      expect(item.value).to eq('xyz')
    end

    it 'returns default_value value when value is blank' do
      item.value = ''

      expect(item.value).to eq('xyz')
      expect(item.raw_value).to be_nil
    end

    it 'returns value when it is set' do
      item.value = 'foo'

      expect(item.value).to eq('foo')
    end
  end

  describe '#section' do
    it 'returns first dot-separated string' do
      expect(item.section).to eq('emails')
    end
  end

  describe '#attribute' do
    it 'returns first dot-separated string' do
      expect(item.attribute).to eq('reply_to')
    end
  end

  describe '#label' do
    it 'returns the label of the item' do
      expected = I18n.t('configuration.emails.fields.reply_to.name')

      expect(item.label).to eq(expected)
    end
  end

  describe '#description' do
    it 'returns the description of the item' do
      expected = I18n.t('configuration.emails.fields.reply_to.description')

      expect(item.description).to eq(expected)
    end

    it 'includes default_value value when applicable' do
      item = described_class.new('maps.border_color', default_value: 'black')

      expected = I18n.t(
        'configuration.maps.fields.border_color.description',
        default_value: 'black'
      )

      expect(item.description).to eq(expected)
    end
  end
end
