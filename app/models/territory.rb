class Territory < ApplicationRecord
  TerritoryError = Class.new(StandardError)

  has_many :householders
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :uuid, presence: true, uniqueness: { case_sensitive: false }

  scope :sorted, -> { order(:name) }

  def initialize(*args)
    super
    self.uuid ||= UniqueId.new
  end

  def to_s
    name
  end

  def self.remove(territory)
    raise TerritoryError unless territory.householders.count.zero?
    territory.delete
    territory
  end
end
