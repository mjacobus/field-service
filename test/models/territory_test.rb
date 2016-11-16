require 'test_helper'

class TerritoryTest < ActiveSupport::TestCase
  def valid_territory
    Territory.make
  end

  test "valid is valid" do
    assert valid_territory.valid?
  end

  test "validates presence of name" do
    territory = valid_territory
    territory.name = nil
    assert !territory.valid?
  end

  test "validates uniqueness of name" do
    first = valid_territory
    first.name = 'theName'
    first.save!

    second = valid_territory
    second.name = 'thename';

    assert !second.valid?
  end

  test "#to_s returns name" do
    record = valid_territory
    record.name = 'thename';

    assert_equal 'thename', "#{record}"
  end
end
