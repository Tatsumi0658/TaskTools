class Todotask < ApplicationRecord
  belongs_to :user, optional: true
end
