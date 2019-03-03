class Admin::User < ApplicationRecord
  def master(user)
    User.find_by(id: current_user.id).update_attributes{ admin_flag: true}
  end

  def unmaster(user)
    User.find_by(id: current_user.id).update_attributes{ admin_flag: false }
  end
end
