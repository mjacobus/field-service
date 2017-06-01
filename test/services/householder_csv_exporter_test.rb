require 'test_helper'

class HouseholderCsvExporterTest < TestCase
  subject { HouseholderCsvExporter.new }

  let(:t1) do
    Territory.new(name: 'território1')
  end

  let(:t2) do
    Territory.new(name: 'território2')
  end

  let(:h1) do
    Householder.new(
      uuid: 'uuid1',
      territory: t1,
      name: 'name 1',
      street_name: 'street 1',
      house_number: '#1',
      show: true,
      updated_at: 2.days.ago
    )
  end

  let(:h2) do
    Householder.new(
      uuid: 'uuid2',
      territory: t2,
      name: 'name 2',
      street_name: 'street 2',
      house_number: '#2',
      show: false,
      updated_at: 3.days.ago
    )
  end

  describe '#export' do
    describe 'with housholders as params' do
      it 'exports householders' do
        result = subject.export([h1, h2])

        expected = <<-HASH
territory_name,street_name,house_number,name,show,uuid,updated_at
território1,street 1,#1,name 1,1,uuid1,#{h1.updated_at.utc.to_s(:db)}
território2,street 2,#2,name 2,0,uuid2,#{h2.updated_at.utc.to_s(:db)}
HASH

        assert_equal expected, result.to_s
      end
    end
  end
end
