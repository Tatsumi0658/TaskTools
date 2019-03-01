class User < ApplicationRecord
  before_validation { email.validation }
  validates :name, presence:true
  validates :email, presence: true, uniqueness: true, format:{ with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true
  has_many :todotasks
  has_secure_password
end
