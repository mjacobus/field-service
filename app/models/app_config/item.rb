# frozen_string_literal: true

class AppConfig
  class Item
    attr_reader :name
    attr_reader :default_value
    attr_accessor :value

    def initialize(name, value = nil, default_value: nil)
      @name = name
      @value = value
      @default_value = default_value
    end

    def value
      raw_value || default_value
    end

    def raw_value
      @value.presence
    end

    def section
      name.split('.').first
    end

    def attribute
      name.split('.').last
    end

    def description
      I18n.t(
        "configuration.#{section}.fields.#{attribute}.description",
        default_value: default_value
      )
    end

    def label
      I18n.t("configuration.#{section}.fields.#{attribute}.name")
    end
  end
end
