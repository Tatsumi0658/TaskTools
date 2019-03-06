class Label < ApplicationRecord
  belongs_to :todotask, optional: true
end
