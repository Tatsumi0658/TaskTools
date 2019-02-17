class UsersController < ApplicationController
  before_action :set_user, only:[:edit, :update, :destroy, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
      flash[:success] = "ユーザーを作成しました"
    else
      render :new
      flash[:danger] = "失敗しました"
    end
  end

  def edit
  end

  def show
  end

  def update
    if @user.update(set_user)
      redirect_to todotasks_path
      flash[:success] = "更新しました"
    else
      render :edit
      flash[:danger] = "失敗しました"
    end
  end

  def destroy
    @user.destroy
    redirect_to todotasks_path
    flash[:success] = "削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
