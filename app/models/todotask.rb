class Todotask < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, optional: true
end
