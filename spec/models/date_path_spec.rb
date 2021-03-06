require 'spec_helper'

describe DatePath do
  subject do
    DatePath.new(
      prefix: 'the_prefix_',
      suffix: '.csv',
      time: Time.new(2001, 0o2, 0o3, 0o4, 0o5, 0o6)
    )
  end

  describe '#to_s' do
    it 'returns a path with prefix, suffix and the time representation' do
      expect(subject.to_s).to eq 'the_prefix_2001-02-03_04-05-06.csv'
    end
  end
end
