class Todotask < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, optional: true
  scope :search_name, -> (name){ where("name LIKE ?", name) }
  scope :search_status, -> (status){ where(status: status) }
  paginates_per 3
  has_many :labels
  accepts_nested_attributes_for :labels
end
