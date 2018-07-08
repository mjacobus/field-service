# frozen_string_literal: true

class AppConfig
  class Section
    def initialize(name)
      @name = name
      @items = []
    end

    def add(name, default_value:)
      item = Item.new("#{@name}.#{name}", default_value: default_value)
      @items.push(item)
    end

    def each(&block)
      @items.each(&block)
    end

    def label
      I18n.t("configuration.#{@name}.name")
    end

    def description
      I18n.t("configuration.#{@name}.description")
    end
  end
end
