require 'rails_helper'

RSpec.describe Territory do
  let(:valid_territory) { Territory.make }

  it 'valid is valid' do
    assert valid_territory.valid?
  end

  it 'validates presence of name' do
    territory = valid_territory
    territory.name = nil
    assert !territory.valid?
  end

  it 'validates presence of city' do
    territory = valid_territory
    territory.city = nil

    expect(territory).not_to be_valid
  end

  it 'validates uniqueness of name' do
    first = valid_territory
    first.name = 'theName'
    first.save!

    second = Territory.make
    second.name = 'thename'

    assert !second.valid?
  end

  it 'validates uniqueness of uuid' do
    first = valid_territory
    first.uuid = UniqueId.new('Id')
    first.save!

    second = Territory.make
    second.uuid = UniqueId.new('id')

    expect(second).not_to be_valid
    expect(first).to be_valid
  end

  it '#uuid has default value' do
    record = Territory.new
    record.save!(validate: false)
    record = Territory.find_by_uuid(record.uuid)

    expect(record.uuid).not_to be_nil
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

    expect do
      Territory.remove(created)
    end.to raise_error(Territory::TerritoryError)

    assert_equal 1, Territory.count
  end

  it '.remove raises when there are assignments assigned to it' do
    created = TerritoryAssignment.make!.territory

    expect do
      created.destroy
    end.to raise_error(Territory::TerritoryError)

    assert_equal 1, Territory.count
  end

  it '.remove raises when there are assignments assigned to it' do
    created = TerritoryAssignment.make!.territory

    expect do
      created.destroy
    end.to raise_error(Territory::TerritoryError)

    assert_equal 1, Territory.count
  end
end
