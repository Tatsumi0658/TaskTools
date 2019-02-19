class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to new_todotask_path
      flash[:success] = t('.success')
    else
      render :new
      flash[:danger] = t('.failed')
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end
end
