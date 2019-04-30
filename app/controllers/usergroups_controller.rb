class UsergroupsController < ApplicationController
  def create
    if Usergroup.where(user_id: current_user.id).where(group_id: params[:group_id]).present?
      redirect_to groups_path
      flash[:danger] = "登録済みです"
    else
      usergroup = current_user.usergroups.create(group_id: params[:group_id])
      redirect_to groups_path
    end
  end

  def destroy
    if @target = Group.find_by(id: params[:group_id])
      if @target.owner_id != current_user.id
        usergroup = current_user.usergroups.find_by(id: params[:id]).destroy
        redirect_to groups_path
      else
        redirect_to groups_path
        flash[:danger] = "グループオーナーは退出できません"
      end
    else
      usergroup = current_user.usergroups.find_by(id: params[:id]).destroy
      redirect_to groups_path
    end
  end
end
