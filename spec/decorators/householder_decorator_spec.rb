# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HouseholderDecorator do
  let(:fake_view_helpers) { FakeViewHelpers.new }

  let(:item) { @item }
  let(:decorator) { @decorator }

  before do
    @territory = double(:territory, id: 4, to_param: ':t_param', name: 'T1')
    @item = double(
      :item,
      id: 1,
      to_param: 1,
      address: 'theAddress',
      do_not_visit_date: nil,
      show: 'show',
      show?: true,
      visit?: true,
      name: 'theName',
      notes: 'theNotes',
      uuid: 'theUuid',
      house_number: 'houseNumber',
      street_name: 'theStreet',
      do_not_visit_date?: false,
      territory: @territory,
      territory_id: ':tid',
      description: 'theDescription'
    )

    @decorator = HouseholderDecorator.new(@item).with_view_helpers(fake_view_helpers)
  end

  it 'extends BaseDecorator' do
    assert @decorator.is_a?(ActiveRecordModelDecorator)
  end

  xit '#edit_url returns correct url' do
    assert_equal '/territories/:t_param/householders/1/edit', @decorator.edit_url
  end

  it '#url returns correct url' do
    assert_equal '/territories/:t_param/householders/1', @decorator.url
  end

  xit '#index_url returns correct url' do
    assert_equal '/territories/:t_param/householders', @decorator.index_url
  end

  it 'delegates name' do
    assert_delegates :name, @decorator, @item
  end

  it 'delegates notes' do
    assert_delegates :notes, @decorator, @item
  end

  it 'delegates name' do
    assert_delegates :uuid, @decorator, @item
  end

  it 'delegates house_number' do
    assert_delegates :house_number, @decorator, @item
  end

  it 'delegates street_name' do
    assert_delegates :street_name, @decorator, @item
  end

  it 'delegates show' do
    assert_delegates :show, @decorator, @item
  end

  it 'delegates territory' do
    assert_delegates :territory, @decorator, @item
  end

  it "#html_classes returns '' when show is true" do
    allow(item).to receive(:show?).and_return(true)

    assert_equal '', @decorator.html_classes.to_s
  end

  it '#html_classes returns do-not-show when show is false' do
    allow(item).to receive(:show?).and_return(false)

    assert_equal 'do-not-show', @decorator.html_classes.to_s
  end

  it '#html_classes returns nothing when when visit is true and do_not_visit_date is not present' do
    allow(@item).to receive(:do_not_visit_date).and_return(nil)

    assert_equal '', @decorator.html_classes.to_s
  end

  it '#html_classes returns nothing when when visit is true and do_not_visit_date is present' do
    allow(@item).to receive(:do_not_visit_date).and_return(Time.now)

    assert_equal 'do-not-visit', @decorator.html_classes.to_s
  end

  xit '#breadcrumbs for existing record' do
    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.territories', '/territories'],
      ['T1', '/territories/:t_param'],
      ['t.titles.householders', '/territories/:t_param/householders'],
      ['theAddress (theName)']
    ]

    assert_equal expected, actual
  end

  xit '#breadcrumbs for new record' do
    allow(@item).to receive(:id) { nil }
    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.territories', '/territories'],
      ['T1', '/territories/:t_param'],
      ['t.titles.householders', '/territories/:t_param/householders'],
      ['t.links.new']
    ]

    assert_equal expected, actual
  end
end
