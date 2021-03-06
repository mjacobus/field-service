class Territory < ApplicationRecord
  TerritoryError = Class.new(StandardError)

  belongs_to :responsible, class_name: 'Publisher', optional: true
  has_many :householders
  has_many :assignments, class_name: 'TerritoryAssignment'
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :uuid, presence: true, uniqueness: { case_sensitive: false }
  validates :city, presence: true

  scope :sorted, -> { order(:name) }
  scope :with_map, -> { where.not(map_coordinates: nil) }

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

  def assigned?
    @assigned ||= current_assignment.present?
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

  # make sure it saves an array of hashes instead of hash of hashes
  # Also, makes sure it saves numbers instead of strings
  def map_coordinates=(coordinates)
    unless coordinates.is_a?(Hash)
      return super(coordinates)
    end

    new_values = coordinates.values.map do |value|
      if value['lat']
        value['lat'] = Float(value['lat'])
      end

      if value['lng']
        value['lng'] = Float(value['lng'])
      end

      value
    end

    super(new_values)
  end

  def mapped?
    map_coordinates.present?
  end

  def map
    TerritoryMap.new(
      coordinates: map_coordinates,
      markers: TerritoryHouseholderMapMarkers.new(householders)
    )
  end

  private

  def ensure_no_children
    !has_children?
  end
end
