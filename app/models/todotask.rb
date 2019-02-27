class Todotask < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, optional: true
  scope :search_name, -> (name){ where("name LIKE ?", name) }
  scope :search_status, -> (status){ where(status: status) }
  paginateper 3
end
