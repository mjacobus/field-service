class Publisher < ApplicationRecord
  validates :name, presence: true

  scope :sorted, -> { order(name: :asc) }

  def self.search(search:)
    search = [nil, search, nil].join('%')
    where('name LIKE :search', search: search)
  end
end
