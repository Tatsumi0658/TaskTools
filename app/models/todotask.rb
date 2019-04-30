class Todotask < ApplicationRecord
  validates :name, presence: true
  belongs_to :user, optional: true
  scope :search_name, -> (name){ where("name LIKE ?", name) }
  scope :search_status, -> (status){ where(status: status) }
  paginates_per 3
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  mount_uploader :uploadfile, UploadfileUploader
end
