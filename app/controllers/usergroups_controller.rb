class UsergroupsController < ApplicationController
  def create
    usergroup = current_user.usergroups.create(group_id: params[:group_id])
    redirect_to groups_path
  end

  def destroy
    usergroup = current_user.usergroups.find_by(id: params[:id]).destroy
    redirect_to groups_path
  end
end
