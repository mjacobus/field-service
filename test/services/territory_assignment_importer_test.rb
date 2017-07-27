require 'test_helper'

class TerritoryAssignmentImporterTest < ActiveSupport::TestCase
  subject { TerritoryAssignmentImporter.new }

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
        exception = assert_raise(RuntimeError) do
          import(territory_name: 'Non Existing')
        end

        assert_equal "Territory 'Non Existing' not found", exception.message
      end

      it 'creates assigns existing territory' do
        import

        assert_equal 'T1', assignment.territory.name
        assert_count(1, 1)
      end
    end

    describe 'publisher' do
      it 'creates a new publisher when one does not exist' do
        import

        assert_equal 'John Doe', assignment.publisher.name
        assert_count(1, 1)
      end

      it 'assigns existing publisher when it exists' do
        Publisher.make!(name: 'John Doe')

        import

        assert_equal 'John Doe', assignment.publisher.name
        assert_count(1, 1)
      end
    end

    describe 'assigned_at' do
      it 'raises an exception when cannot parse date' do
        exception = assert_raise(RuntimeError) do
          import(assigned_at: '')
        end

        assert_equal "Invalid date: ''", exception.message
      end

      it 'assigns the date when it is parseable' do
        import

        assert_equal Date.new(2013, 11, 30), assignment.assigned_at
      end

      it 'cannot be nil' do
        exception = assert_raise(RuntimeError) do
          import(assigned_at: nil)
        end

        assert_equal "Invalid date: ''", exception.message
      end
    end

    describe 'returned_at' do
      it 'assigns the date when it is parseable' do
        import(returned_at: '01.02.2004')

        assert_equal Date.new(2004, 0o2, 0o1), assignment.returned_at
      end

      it 'can be nil' do
        import(returned_at: '')

        assert_nil assignment.returned_at
      end
    end
  end

  def import(overrides = {})
    subject.import(import_data.merge(overrides))
  end

  def assert_count(territory, publisher)
    assert_equal territory, Territory.count
    assert_equal publisher, Publisher.count
  end
end
