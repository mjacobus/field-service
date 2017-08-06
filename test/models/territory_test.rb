require 'test_helper'

class TerritoryTest < ActiveSupport::TestCase
  def valid_territory
    Territory.make
  end

  it 'valid is valid' do
    assert valid_territory.valid?
  end

  it 'validates presence of name' do
    territory = valid_territory
    territory.name = nil
    assert !territory.valid?
  end

  it 'validates uniqueness of name' do
    first = valid_territory
    first.name = 'theName'
    first.save!

    second = valid_territory
    second.name = 'thename'

    assert !second.valid?
  end

  it 'validates uniqueness of uuid' do
    first = valid_territory
    first.uuid = UniqueId.new('Id')
    first.save!

    second = valid_territory
    second.uuid = UniqueId.new('id')

    assert !second.valid?
    assert first.valid?
  end

  it '#uuid has default value' do
    record = Territory.new
    record.save!(validate: false)
    record = Territory.find_by_uuid(record.uuid)

    assert_not_nil record.uuid
    assert_instance_of Territory, record
    assert_instance_of Territory, Territory.find_by_uuid(record.uuid)
  end

  it 'validates presence of #uuid' do
    record = Territory.make
    record.uuid = nil

    assert !record.valid?
  end

  it '#to_s returns name' do
    record = valid_territory
    record.name = 'thename'

    assert_equal 'thename', record.to_s
  end

  it 'has many householders' do
    assert_respond_to valid_territory, :householders
  end

  it '.remove deletes when no households' do
    created = Territory.make!

    deleted = Territory.remove(created)

    assert_equal 0, Territory.count
    assert_same created, deleted
  end

  it '.remove raises when there are houlseholders assigned to it' do
    created = Householder.make!.territory

    assert_raise(Territory::TerritoryError) do
      Territory.remove(created)
    end

    assert_equal 1, Territory.count
  end
end
