require 'test_helper'

class HouseholderImporterTest < ActiveSupport::TestCase
  def import_data
    {
      territory_name: 'T1',
      street_name: 'street name',
      house_number: 'house number',
      name: 'householder name',
      show: 'no'
    }
  end

  def import(overrides = {})
    subject.import(import_data.merge(overrides))
  end

  def subject
    HouseholderImporter.new
  end

  test '#import creates a new record when no uuid' do
    import

    territory = Territory.first
    householder = Householder.first

    assert_equal 1, Territory.count
    assert_equal 1, Householder.count
    assert_equal 'T1', territory.name
    assert_equal 'street name', householder.street_name
    assert_equal 'house number', householder.house_number
    assert_equal 'householder name', householder.name
    assert_equal false, householder.show?
    assert_not_nil householder.uuid
    assert_not_nil territory.uuid
    assert_equal territory, householder.territory
  end

  test '#import updates when has a new uuid and date' do
    import(uuid: 'the-uuid')
    import(uuid: 'the-uuid', name: 'other name', updated_at: 1.minute.from_now)

    householder = Householder.first

    assert_equal 1, Territory.count
    assert_equal 1, Householder.count
    assert_equal 'other name', householder.name
  end

  test '#import updates when has a new uuid' do
    import(uuid: 'the-uuid', updated_at: '2001-02-03 01:02:03', territory_name: 'T1')
    import(uuid: 'the-uuid', updated_at: '2001-02-03 01:01:03', territory_name: 'T2')

    householder = Householder.first

    assert_equal 1, Householder.count
    assert_equal 1, Territory.count
    assert_equal 'T1', householder.territory.name
  end

  test '#import updates territory refence when applicable' do
    import(uuid: 'the-uuid', updated_at: '2001-02-03 01:02:03', territory_name: 'T1')
    import(uuid: 'the-uuid', updated_at: '2001-02-03 01:01:03', territory_name: 'T2')
    import(uuid: 'the-uuid', updated_at: '2001-03-03 01:01:03', territory_name: 'T2')

    householder = Householder.first

    assert_equal 'T2', householder.territory.name
    assert_equal 1, Householder.count
    assert_equal 2, Territory.count
  end
end
