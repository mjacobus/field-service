class Householder < ApplicationRecord
  belongs_to :territory

  validates :name, presence: true
  validates :street_name, presence: true
  validates :house_number, presence: true

  scope :sorted, -> { order(:street_name, :house_number) }
end
