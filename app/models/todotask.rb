class Todotask < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, optional: true
  paginates_per 3
end
