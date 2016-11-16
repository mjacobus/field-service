class Territory < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    name
  end
end
