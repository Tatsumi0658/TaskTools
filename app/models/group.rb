class Group < ApplicationRecord
  validates :name, presence: true, length: { in: 1..30 }
  has_many :usergroups, dependent: :destroy
end
