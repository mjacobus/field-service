class Publisher < ApplicationRecord
  validates :name, presence: true

  scope :sorted, -> { order(name: :asc) }
end
