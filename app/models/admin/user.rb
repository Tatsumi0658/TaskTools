class Admin::User < ActiveRecord::Base
  before_save :check

  private

  def check
    true_user = User.where(admin_flag: true).count
    if true_user == 1
      redirect_to admin_users_path
    end
  end
end
