class Publisher < ApplicationRecord
  has_many :assignments, class_name: 'TerritoryAssignment'
  validates :name, presence: true

  scope :sorted, -> { order(name: :asc) }

  def self.search(search:)
    search = [nil, search, nil].join('%')
    where('name LIKE :search', search: search)
  end

  def destroy
    self.class.remove(self)
  end

  def self.remove(publisher)
    !publisher.has_children? || raise(DomainError, 'Cannot delete publisher')
    publisher.delete
    publisher
  end

  def has_children?
    !assignments.count.zero?
  end
end
