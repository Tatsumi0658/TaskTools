class UsersController < ApplicationController
  before_action :set_user, only:[:destroy, :show]

  def new
    if current_user.present?
      redirect_to todotasks_path
      flash[:danger] = "権限がありません"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to todotasks_path
      flash[:success] = t('.success')
    else
      flash[:danger] = t('.failed')
      render :new
    end
  end

  def show
    unless @user.id == current_user.id
      redirect_to todotasks_path
      flash[:danger] = "閲覧権限がありません"
    end
  end

  def destroy
    @user.destroy
    redirect_to todotasks_path
    flash[:success] = t('.success')
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
