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

  describe '#slug' do
    let(:territory) { Territory.make!(name: '100 B') }

    it 'can be created' do
      territory.reload
      expect(territory.slug).to eq('100-b')
    end

    it 'can be updated' do
      territory.name = '101 C'
      territory.save!

      territory.reload

      expect(territory.slug).to eq('101-c')
    end

    it 'is the param version of the territory' do
      expect(territory.to_param).to eq(territory.slug)
    end
  end

  describe '.find_by_slug' do
    let(:territory) { Territory.make!(name: '100 B') }

    it 'can be found by slug' do
      t = Territory.find_by_slug(territory.slug)

      expect(t.id).to eq(territory.id)
    end

    it 'raises error when not found' do
      expect do
        Territory.find_by_slug('unexisting')
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#map_coordinates' do
    let(:coordinates) { [{ 'lat' => 1, 'lon' => 2 }] }

    it 'defaults to nil' do
      expect(Territory.new.map_coordinates).to be_nil
    end

    context 'when coordinates are given in hash' do
      it 'converts hash to array' do
        coordinates = {
          '1' => { 'lat' => '1.2', 'lng' => '2.1' },
          '2' => { 'lat' => nil, 'lng' => nil }
        }

        territory = Territory.make!(map_coordinates: coordinates)

        territory.reload

        expected = [
          { 'lat' => 1.2, 'lng' => 2.1 },
          { 'lat' => nil, 'lng' => nil }
        ]

        expect(territory.map_coordinates).to eq(expected)
      end
    end

    it 'can save a array of hashes' do
      territory = Territory.make!(map_coordinates: coordinates)

      territory.reload

      expect(territory.map_coordinates).to eq coordinates
    end

    it 'saves strings as strings' do
      territory = Territory.make!(map_coordinates: coordinates.to_json)

      territory.reload

      expect(territory.map_coordinates).to eq coordinates.to_json
    end
  end
end
