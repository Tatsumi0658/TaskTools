class Admin::UsersController < ApplicationController
  before_action :set_user, only:[:show, :destroy, :edit, :update]
  before_action :check_admin
  before_action :check, only:[:create, :update, :destroy]

  def index
    @users = User.all.includes(:todotasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
      flash[:success] = "ユーザー登録しました"
    else
      flash[:danger] = "登録できませんでした"
      render :new
    end
  end

  def show
    @todotasks = Todotask.where(user_id: @user.id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
      flash[:success] = "更新しました"
    else
      flash[:danger] = "失敗しました"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
    flash[:danger] = "削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin_flag)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin
    unless current_user.admin_flag?
      redirect_to todotasks_path
      flash[:danger] = "権限がありません"
    end
  end

  def check
    true_user = User.where(admin_flag: true).count
    if true_user == 1 && params[:user].present? && params[:user][:admin_flag].blank?
      redirect_to admin_users_path
    end
  end

end
