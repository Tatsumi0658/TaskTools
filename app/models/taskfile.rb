class Taskfile < ApplicationRecord
  mount_uploader :uploadfiles, UploadfilesUploader
  belongs_to :todotask
end
