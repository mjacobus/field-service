class Territory < ApplicationRecord
  TerritoryError = Class.new(StandardError)

  has_many :householders
  has_many :assignments, class_name: 'TerritoryAssignment'
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

  def current_assignment
    @current_assignment ||= assignments.where(returned: false).last
  end

  def need_to_be_returned?
    assignment = current_assignment

    return false unless assignment
    assignment.pending_return?
  end
end
