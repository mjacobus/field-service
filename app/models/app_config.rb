# frozen_string_literal: true

# Note: Do not forget to add proper translations in field-service-{lang}.yml
# Refer to the pt-BR config for reference, under the section configuration:
class AppConfig
  include Enumerable

  def initialize
    @sections = []

    # TODO: Set missing configurations as commented
    #
    # section = Section.new('emails')
    # section.add('reply_to')
    # @sections.push(section)

    # section = Section.new('maps')
    # section.add('border_color', default_value: nil)
    # section.add('border_width', default_value: nil)
    # section.add('default_center', default_value: '53.5535103,9.9899721')
    # @sections.push(section)

    section = Section.new('pdf')
    section.add('householders_per_page', default_value: 40)
    section.add('font_size', default_value: '12px')
    section.add('font_family', default_value: "Verdana, Arial, 'OpenSansRegular'")
    section.add('page_height', default_value: 297)
    section.add('page_width', default_value: 210)
    section.add('margin_top', default_value: 4)
    section.add('margin_bottom', default_value: 0)
    section.add('margin_right', default_value: 0)
    section.add('margin_left', default_value: 0)
    @sections.push(section)
  end

  def each_section(&block)
    @sections.each(&block)
  end

  def each(&block)
    each_section do |section|
      section.each(&block)
    end
  end

  def get(key)
    find { |item| item.name == key } || raise(ArgumentError, "invalid key '#{key}'")
  end

  def get_int(key)
    Integer(get_value(key))
  end

  def get_value(key)
    get(key).value
  end

  def set(key, value)
    get(key).value = value
  end
end
