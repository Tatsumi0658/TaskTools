class TaskLabel < ApplicationRecord
  belongs_to :todotask
  belongs_to :label
end
