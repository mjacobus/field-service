require 'test_helper'

class HouseholderTest < ActiveSupport::TestCase
  def valid_record
    Householder.make
  end

  test "valid record is considered valid" do
    assert valid_record.valid?
  end

  test "validates presence of #street_name" do
    record = valid_record
    record.street_name = nil

    assert !record.valid?
  end

  test "validates presence of #name" do
    record = valid_record
    record.name = nil

    assert !record.valid?
  end

  test "validates presence of #house_number" do
    record = valid_record
    record.house_number = nil

    assert !record.valid?
  end
end
