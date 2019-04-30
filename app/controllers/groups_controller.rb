class GroupsController < ApplicationController
  before_action :set_group, only:[:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      Usergroup.create(user_id: current_user.id, group_id: @group.id)
      redirect_to groups_path
      flash[:success] = t('.success')
    else
      render :new
    end
  end

  def show
    if current_user.usergroups.find_by(group_id: @group.id)
      @usergroup = current_user.usergroups.find_by(group_id: @group.id)
      @users = Usergroup.where(group_id: @group.id)
      @tasks = Todotask.all
    else
      redirect_to groups_path
      flash[:danger] = t('.failed')
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
      flash[:success]= t('.success')
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
    flash[:danger]= t('.success')
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name,:owner_id)
  end
end
