require 'test_helper'

class HouseholderImporterTest < ActiveSupport::TestCase
  subject { HouseholderImporter.new }
  let(:householder) { Householder.last }
  let(:territory) { Territory.last }

  let(:import_data) do
    {
      territory_name: 'T1',
      street_name: 'street name',
      house_number: 'house number',
      name: 'householder name',
      show: 'no'
    }
  end

  describe '#import' do
    describe 'when has no uuid' do
      before { import }

      it 'creates a new record in the database' do
        assert_count(1, 1)
      end

      it '#import creates a new record when no uuid' do
        territory.name.must_equal 'T1'
        householder.street_name.must_equal 'street name'
        householder.house_number.must_equal 'house number'
        householder.name.must_equal 'householder name'
        householder.show?.must_equal false
        assert_not_nil householder.uuid
        assert_not_nil territory.uuid
        territory.must_equal(householder.territory)
      end
    end

    it 'imports #show correctly' do
      import(show: nil)

      assert householder.show?
    end

    describe 'when has uuid and date' do
      it 'when has uuid and date' do
        import(uuid: 'the-uuid')
        import(uuid: 'the-uuid', name: 'other name', updated_at: 1.minute.from_now)

        householder = Householder.first
        assert_count(1, 1)
        householder.name.must_equal 'other name'
      end
    end

    context 'when the date has older data' do
      it 'does not import the data' do
        import(uuid: 'the-uuid', updated_at: '2001-02-03 01:02:03', territory_name: 'T1')
        import(uuid: 'the-uuid', updated_at: '2001-02-03 01:01:03', territory_name: 'T2')

        householder.territory.name.must_equal 'T1'
      end
    end

    it 'updates territory when it changes' do
      import(uuid: 'the-uuid', updated_at: '2001-02-03 01:02:03', territory_name: 'T1')
      import(uuid: 'the-uuid', updated_at: '2001-03-03 01:01:03', territory_name: 'T2')

      householder.territory.name.must_equal 'T2'
      assert_count(1, 2)
    end
  end

  describe '#import_batch' do
    it 'imports collection' do
      collection = [
        import_data.dup,
        import_data.dup.merge(uuid: 'the_uuid', territory_name: 'the-name')
      ]

      subject.import_batch(collection)

      assert_count(2, 2)
    end

    it 'rollsback on failure' do
      collection = [
        import_data.dup,
        import_data.dup.merge(foo: :bar)
      ]

      assert_raise(ArgumentError) do
        subject.import_batch(collection)
      end

      assert_count(0, 0)
    end
  end

  def import(overrides = {})
    subject.import(import_data.merge(overrides))
  end

  def assert_count(householder, territory)
    assert_equal householder, Householder.count
    assert_equal territory, Territory.count
  end
end
