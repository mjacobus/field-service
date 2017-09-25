require 'rails_helper'

RSpec.describe HouseholderImporter do
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
        expect(territory.name).to eq('T1')

        expect(householder.street_name).to eq('street name')
        expect(householder.house_number).to eq('house number')
        expect(householder.name).to eq('householder name')
        expect(householder.show?).to be false

        expect(householder.uuid).not_to be_nil
        expect(territory.uuid).not_to be_nil

        expect(householder.territory).to eq(territory)
      end
    end

    describe '#show' do
      it 'imports nil as true' do
        import(show: nil)

        assert householder.show?
      end

      it 'imports true as true' do
        import(show: true)

        assert householder.show?
      end

      it 'imports false as false' do
        import(show: false)

        refute householder.show?
      end

      it 'imports 1 as true' do
        import(show: 1)

        assert householder.show?
      end

      it 'imports "1" as true' do
        import(show: '1')

        assert householder.show?
      end

      it 'imports 0 as false' do
        import(show: 0)

        refute householder.show?
      end

      it 'imports "0" as false' do
        import(show: '0')

        refute householder.show?
      end
    end

    describe '#do_not_visit_date' do
      it 'accepts date in the YYYY-mm-dd format' do
        import(do_not_visit_date: '2017-02-01')

        expect(householder.do_not_visit_date).to eq Date.new(2017, 2, 1)
      end

      it 'accepts date in th dd.mm.yy format' do
        import(do_not_visit_date: '01.02.17')

        expect(householder.do_not_visit_date).to eq Date.new(2017, 2, 1)
      end

      it 'accepts date in th d.m.yy format' do
        import(do_not_visit_date: '1.2.17')

        expect(householder.do_not_visit_date).to eq Date.new(2017, 2, 1)
      end

      it 'accepts date in the d.m.yyyy format' do
        import(do_not_visit_date: '1.2.2017')

        expect(householder.do_not_visit_date).to eq Date.new(2017, 2, 1)
      end

      it 'accepts Date' do
        date = Date.new(2017, 2, 1)

        import(do_not_visit_date: date)

        expect(householder.do_not_visit_date).to eq date
      end

      it 'accepts blank' do
        import(do_not_visit_date: '')

        expect(householder.do_not_visit_date).to be nil
      end

      it 'accepts nil' do
        import(do_not_visit_date: nil)

        expect(householder.do_not_visit_date).to be nil
      end
    end

    describe 'when has uuid and date' do
      it 'when has uuid and date' do
        import(uuid: 'the-uuid')
        import(uuid: 'the-uuid', name: 'other name', updated_at: 1.minute.from_now)

        householder = Householder.first
        assert_count(1, 1)
        expect(householder.name).to eq 'other name'
      end
    end

    context 'when the date has older data' do
      it 'does not import the data' do
        import(uuid: 'the-uuid', updated_at: '2001-02-03 01:02:03', territory_name: 'T1')
        import(uuid: 'the-uuid', updated_at: '2001-02-03 01:01:03', territory_name: 'T2')

        expect(householder.territory.name).to eq 'T1'
      end
    end

    it 'updates territory when it changes' do
      import(uuid: 'the-uuid', updated_at: '2001-02-03 01:02:03', territory_name: 'T1')
      import(uuid: 'the-uuid', updated_at: '2001-03-03 01:01:03', territory_name: 'T2')

      expect(householder.territory.name).to eq 'T2'
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

      expect do
        subject.import_batch(collection)
      end.to raise_error(RuntimeError, 'Line 3 : unknown keyword: foo')

      assert_count(0, 0)
    end
  end

  def import(overrides = {})
    subject.import(import_data.merge(overrides))
  end

  def assert_count(householder, territory)
    expect(Householder.count).to eq householder
    expect(Territory.count).to eq territory
  end
end
