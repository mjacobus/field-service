# frozen_string_literal: true

class Configuration < ApplicationRecord
  def self.config
    first || new(values: '{}')
  end

  def self.create_config_object
    values = JSON.parse(config.values)
    config_with_values(values)
  end

  def self.update(values)
    values = config_with_values(values).each_with_object({}) do |item, hash|
      if item.raw_value
        hash[item.name] = item.raw_value
      end
    end

    config.tap do |c|
      c.values = JSON.dump(values)
      c.save!
    end
  end

  def self.config_with_values(values)
    AppConfig.new.tap do |config|
      values.each do |key, value|
        config.set(key, value)
      end
    end
  end
end
