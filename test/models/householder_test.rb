require 'test_helper'

class HouseholderTest < ActiveSupport::TestCase
  def valid_record
    Householder.make
  end

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

    assert_not_nil record.uuid
    assert_instance_of Householder, record
    assert_instance_of Householder, Householder.find_by_uuid(record.uuid)
  end

  it 'validates presence of #house_number' do
    record = valid_record
    record.house_number = nil

    assert !record.valid?
  end

  it 'can update geocode' do
    subject = Householder.new(street_name: 'the street', house_number: 'the number')

    data = {
      'results' => [
        {
          'geometry' => {
            'location' => {
              'lat' => 1.23,
              'lng' => 3.21
            }
          }
        }
      ]
    }

    Koine::GoogleMapsClient.any_instance.stubs(:geocode)
                           .with(address: 'the street the number').returns(data)

    subject.update_geolocation

    assert_equal 1.23, subject.lat
    assert_equal 3.21, subject.lon
  end
end
