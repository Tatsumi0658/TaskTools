class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :todotask_task_labels, through: :task_label, source: :todotask
end
