require 'test_helper'

class DatePathTest < ActiveSupport::TestCase
  subject do
    DatePath.new(
      prefix: 'the_prefix_',
      suffix: '.csv',
      time: Time.new(2001, 0o2, 0o3, 0o4, 0o5, 0o6)
    )
  end

  describe '#to_s' do
    it 'returns a path with prefix, suffix and the time representation' do
      assert_equal 'the_prefix_2001-02-03_04-05-06.csv', subject.to_s
    end
  end
end
