require 'rails_helper'

RSpec.describe ActiveRecordModelDecorator do
  before do
    @klass = Class.new(ActiveRecordModelDecorator) do
      def index_url
        '/resource_name'
      end
    end

    @item = double(
      to_param: 1,
      persisted?: true,
      name: 'theName',
      description: 'theDescription'
    )

    @decorator = @klass.new(@item)
  end

  it 'extends BaseDecorator' do
    assert @decorator.is_a?(::BaseDecorator)
  end

  it '#edit_url returns correct url' do
    assert_equal '/resource_name/1/edit', @decorator.edit_url
  end

  it '#new_url returns correct url' do
    assert_equal '/resource_name/new', @decorator.new_url
  end

  it '#url returns correct url' do
    assert_equal '/resource_name/1', @decorator.url
  end

  it '#index_url returns correct url' do
    assert_equal '/resource_name', @decorator.index_url
  end

  it 'can get form object' do
    assert_equal @item, @decorator.form_object
  end

  it '#form_url returns correct form url' do
    assert_equal '/resource_name/1', @klass.new(@item).form_url
    assert_equal '/resource_name', @klass.new(double(persisted?: false)).form_url
  end
end
