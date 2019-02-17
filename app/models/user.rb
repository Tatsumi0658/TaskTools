class User < ApplicationRecord
  has_many :todotasks
  has_secure_password
end
