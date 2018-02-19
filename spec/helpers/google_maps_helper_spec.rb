require 'rails_helper'

RSpec.describe GoogleMapsHelper, type: :helper do
  let(:key) { 'AIzaSyCMFbHjf-I2rApFaatnmukLyfb1VIB8Jhk' }
  # <script src="https://maps.googleapis.com/maps/api/js?key=<%= key %>"></script>

  describe '#google_maps' do
    it 'returns a singleton instance of GoogleMapsHelperObject' do
      expect(helper.google_maps).to be_a(GoogleMapsHelper::GoogleMapsHelperObject)
      expect(helper.google_maps).to be(helper.google_maps)
    end
  end

  describe GoogleMapsHelper::GoogleMapsHelperObject do
    let(:subject) { GoogleMapsHelper::GoogleMapsHelperObject.new(helper) }

    describe '#js_source' do
      it 'returns the js_source with key' do
        expected = "https://maps.googleapis.com/maps/api/js?key=#{key}"

        expect(subject.js_source).to eq(expected)
      end

      it 'adds the callbacks and libraries' do
        expected = 'https://maps.googleapis.com/maps/api/js?' \
          "key=#{key}&libraries=drawing&callback=foo"

        expect(subject.js_source(libraries: 'drawing', callback: 'foo')).to eq(expected)
      end
    end
  end
end
