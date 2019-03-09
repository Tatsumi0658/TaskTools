class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :todotasks, through: :task_labels
end
