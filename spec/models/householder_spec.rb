require 'rails_helper'

RSpec.describe Householder do
  describe '#house_number' do
    it 'sets house_number_as_int' do
      subject.house_number = '1'
      expect(subject.house_number).to eq('1')
      expect(subject.house_number_as_int).to be(1)

      subject.house_number = nil
      expect(subject.house_number_as_int).to be(0)

      subject.house_number = '123'
      expect(subject.house_number_as_int).to be(123)

      subject.house_number = '123 A'
      expect(subject.house_number_as_int).to be(123)
    end
  end

  describe 'default_order' do
    let!(:ab)     { Householder.make!(street_name: 'b', house_number: 'A') }
    let!(:a)      { Householder.make!(street_name: 'a', house_number: 'A') }
    let!(:one_a)  { Householder.make!(street_name: 'a', house_number: '1 A') }
    let!(:one)    { Householder.make!(street_name: 'a', house_number: 1) }
    let!(:eleven) { Householder.make!(street_name: 'a', house_number: 11) }
    let!(:ten)    { Householder.make!(street_name: 'a', house_number: 10) }
    let!(:twenty) { Householder.make!(street_name: 'a', house_number: 20) }

    it 'orders correctly' do
      expected = [
        a,
        one,
        one_a,
        ten,
        eleven,
        twenty,
        ab
      ]

      expect(Householder.all.to_a).to eq(expected)
    end
  end
end
