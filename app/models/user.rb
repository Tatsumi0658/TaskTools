class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name, presence:true
  validates :email, presence: true, uniqueness: true, format:{ with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true
  has_many :todotasks, dependent: :destroy
  has_many :usergroups, dependent: :destroy
  has_many :usergroup_groups, through: :usergroups, source: :group
  before_update :user_should_have_at_least_one_login_update
  before_destroy :user_should_have_at_least_one_login_delete

  mount_uploader :icon, IconUploader

  private

  def user_should_have_at_least_one_login_delete
    # もしユーザーのLoginProviderが1つしか無いのに、消そうとしていたら
    if User.where(admin_flag: true).count == 1 && self.admin_flag?
      throw :abort
    end
  end

  def user_should_have_at_least_one_login_update
    # もしユーザーのLoginProviderが1つしか無いのに、消そうとしていたら
    if User.where(admin_flag: true).count == 1 && self.admin_flag == false
      throw :abort
    end
  end


end
