class Territory < ApplicationRecord
  TerritoryError = Class.new(StandardError)

  has_many :householders
  has_many :assignments, class_name: 'TerritoryAssignment'
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :uuid, presence: true, uniqueness: { case_sensitive: false }
  validates :city, presence: true

  scope :sorted, -> { order(:name) }

  def initialize(*args)
    super
    self.uuid ||= UniqueId.new
  end

  def to_s
    name
  end

  def self.remove(territory)
    raise TerritoryError if territory.has_children?
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

  def has_children?
    !householders.count.zero? || !assignments.count.zero?
  end

  def destroy
    self.class.remove(self)
  end

  def name=(value)
    self.slug = nil
    super(value)

    unless value.nil?
      self.slug = value.to_s.parameterize
    end
  end

  def self.find_by_slug(slug)
    find_by!(slug: slug)
  end

  def to_param
    slug
  end

  private

  def ensure_no_children
    !has_children?
  end
end
