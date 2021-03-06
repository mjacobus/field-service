# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Householder do
  describe '#house_number' do
    it 'sets house_number_as_int' do
      subject.house_number = '1'
      expect(subject.house_number).to eq('1')
      expect(subject.house_number_as_int).to be(1)

      subject.house_number = nil
      expect(subject.house_number_as_int).to be(0)

      subject.house_number = '123'
      expect(subject.house_number_as_int).to be(123)

      subject.house_number = '123 A'
      expect(subject.house_number_as_int).to be(123)
    end
  end

  describe '#street_name' do
    it 'sets normalized street_name as well' do
      householder = Householder.make!(street_name: 'Somethingstr.')

      last = Householder.last

      expect(householder.normalized_street_name).to eq('Somethingstraße')
      expect(last.normalized_street_name).to eq('Somethingstraße')

      last.update(street_name: 'Other str.')

      expect(Householder.last.normalized_street_name).to eq('Other straße')
    end
  end

  describe 'default_order' do
    let!(:ab)     { Householder.make!(street_name: 'b', house_number: 'A') }
    let!(:a)      { Householder.make!(street_name: 'a', house_number: 'A') }
    let!(:one_a)  { Householder.make!(street_name: 'a', house_number: '1 A') }
    let!(:one)    { Householder.make!(street_name: 'a', house_number: 1) }
    let!(:eleven) { Householder.make!(street_name: 'a', house_number: 11) }
    let!(:ten)    { Householder.make!(street_name: 'a', house_number: 10) }
    let!(:twenty) { Householder.make!(street_name: 'a', house_number: 20) }

    it 'orders correctly' do
      expected = [
        a,
        one,
        one_a,
        ten,
        eleven,
        twenty,
        ab
      ]

      expect(Householder.all.to_a).to eq(expected)
    end
  end

  describe '#normalized_street_name' do
    it 'normalizes street names' do
      allow_any_instance_of(StreetNameNormalizer)
        .to receive(:normalize).with('raw') { 'norm' }

      subject.street_name = 'raw'
      expect(subject.normalized_street_name).to eq('norm')
    end
  end

  describe '#validation' do
    let(:valid_record) { Householder.make }

    it 'valid record is considered valid' do
      assert valid_record.valid?
    end

    it 'validates presence of #street_name' do
      record = valid_record
      record.street_name = nil

      assert !record.valid?
    end

    it 'validates presence of #name' do
      record = valid_record
      record.name = nil

      assert !record.valid?
    end

    it 'validates presence of #uuid' do
      record = valid_record
      record.uuid = nil

      assert !record.valid?
    end

    it 'validates uniqueness of #uuid' do
      record = Householder.make!
      record.uuid = UniqueId.new('Foo')
      record.save!

      other = valid_record
      other.uuid = 'foo'

      assert record.valid?
      assert !other.valid?
    end

    it '#uuid has default value' do
      record = Householder.new
      record.save!(validate: false)
      record = Householder.find_by_uuid(record.uuid)

      expect(record.uuid).not_to be_nil
      assert_instance_of Householder, record
      assert_instance_of Householder, Householder.find_by_uuid(record.uuid)
    end

    it 'validates presence of #house_number' do
      record = valid_record
      record.house_number = nil

      assert !record.valid?
    end
  end

  describe '#update_geolocation' do
    let(:householder) do
      Householder.new(
        street_name: 'the street',
        house_number: 'the number',
        lat: 1,
        lon: 2,
        territory: Territory.new(city: 'city name')
      )
    end

    let(:results) do
      [
        {
          'geometry' => {
            'location' => {
              'lat' => 1.23,
              'lng' => 3.21
            }
          }
        }
      ]
    end

    before do
      allow_any_instance_of(Koine::GoogleMapsClient).to receive(:geocode)
        .with(address: 'the street the number, city name').and_return('results' => results)
    end

    describe 'when there are results' do
      it 'can update geocode' do
        householder.update_geolocation

        expect(householder.lat).to eq 1.23
        expect(householder.lon).to eq 3.21
      end
    end

    describe 'when there are no results' do
      let(:results) { [] }

      it 'can nilifies geolocaiton when result is empty' do
        householder.update_geolocation

        expect(householder.lat).to be_nil
        expect(householder.lon).to be_nil
      end
    end
  end

  describe '.search' do
    let(:perform) { described_class.search('John str.') }

    it 'returns relevant data' do
      one = Householder.make!(name: 'The John Doe', street_name: 'some strasse')
      Householder.make!(name: 'Someone else', street_name: 'some strasse')

      expect(perform.pluck(:name, :street_name)).to be_equal_to(
        [
          [
            one.name,
            one.street_name
          ]
        ]
      )
    end
  end
end
