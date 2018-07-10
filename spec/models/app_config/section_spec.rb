# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AppConfig::Section do
  subject(:section) { described_class.new('maps') }

  it 'adds items' do
    section.add('f1', default_value: 'v1')
    section.add('f2', default_value: 'v2')

    items = []

    section.each do |item|
      items << [item.name, item.default_value]
    end

    expect(items).to eq([['maps.f1', 'v1'], ['maps.f2', 'v2']])
  end

  it 'has an internationalized #label' do
    expected = I18n.t('configuration.maps.name')

    expect(subject.label).to eq(expected)
  end

  it 'has an internationalized #description' do
    expected = I18n.t('configuration.maps.description')

    expect(subject.description).to eq(expected)
  end
end
