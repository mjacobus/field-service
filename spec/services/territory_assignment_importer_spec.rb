require 'rails_helper'

RSpec.describe TerritoryAssignmentImporter do
  let(:assignment) { TerritoryAssignment.last }
  let(:publisher) { Publisher.last }

  let(:import_data) do
    {
      territory_name: 'T1',
      publisher_name: 'John Doe',
      assigned_at: '30.11.13',
      returned_at: '01.02.14'
    }
  end

  describe '#import' do
    before do
      Territory.make!(name: import_data[:territory_name])
    end

    describe 'territory' do
      it 'raises an exception when territory was not created' do
        expect do
          import(territory_name: 'Non Existing')
        end.to raise_error(RuntimeError, "Territory 'Non Existing' not found")
      end

      it 'creates assigns existing territory' do
        import

        expect(assignment.territory.name).to eq 'T1'
        assert_count(1, 1)
      end
    end

    describe 'publisher' do
      it 'creates a new publisher when one does not exist' do
        import

        expect(assignment.publisher.name). to eq 'John Doe'
        assert_count(1, 1)
      end

      it 'assigns existing publisher when it exists' do
        Publisher.make!(name: 'John Doe')

        import

        expect(assignment.publisher.name). to eq 'John Doe'
        assert_count(1, 1)
      end
    end

    describe 'assigned_at' do
      it 'raises an exception when cannot parse date' do
        expect do
          import(assigned_at: '')
        end.to raise_error(RuntimeError, "Invalid date: ''")
      end

      it 'assigns the date when it is parseable' do
        import

        date = Date.new(2013, 11, 30)

        expect(assignment.assigned_at).to eq date
      end

      it 'cannot be nil' do
        expect do
          import(assigned_at: nil)
        end.to raise_error RuntimeError, "Invalid date: ''"
      end
    end

    describe 'returned_at' do
      it 'assigns the date when it is parseable' do
        import(returned_at: '01.02.2004')

        date = Date.new(2004, 0o2, 0o1)

        expect(assignment.returned_at).to eq date
      end

      it 'can be nil' do
        import(returned_at: '')

        expect(assignment.returned_at).to be nil
      end
    end
  end

  def import(overrides = {})
    subject.import(import_data.merge(overrides))
  end

  def assert_count(territory, publisher)
    expect(Territory.count). to eq territory
    expect(Publisher.count). to eq publisher
  end
end
