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
      do_not_visit_date: '01.02.17',
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

    describe '#do_not_visit_date' do
      it 'accepts date in the YYYY-mm-dd format' do
        import(do_not_visit_date: '2017-02-01')

        householder.do_not_visit_date.must_equal Date.new(2017, 2, 1)
      end

      it 'accepts date in th dd.mm.yy format' do
        import(do_not_visit_date: '01.02.17')

        householder.do_not_visit_date.must_equal Date.new(2017, 2, 1)
      end

      it 'accepts date in th d.m.yy format' do
        import(do_not_visit_date: '1.2.17')

        householder.do_not_visit_date.must_equal Date.new(2017, 2, 1)
      end

      it 'accepts date in the d.m.yyyy format' do
        import(do_not_visit_date: '1.2.2017')

        householder.do_not_visit_date.must_equal Date.new(2017, 2, 1)
      end

      it 'accepts Date' do
        date = Date.new(2017, 2, 1)

        import(do_not_visit_date: date)

        householder.do_not_visit_date.must_equal date
      end

      it 'accepts blank' do
        import(do_not_visit_date: '')

        householder.do_not_visit_date.must_be_nil
      end

      it 'accepts nil' do
        import(do_not_visit_date: nil)

        householder.do_not_visit_date.must_be_nil
      end
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

      exception = assert_raise(RuntimeError) do
        subject.import_batch(collection)
      end

      exception.message.must_equal 'Line 3 : unknown keyword: foo'

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
