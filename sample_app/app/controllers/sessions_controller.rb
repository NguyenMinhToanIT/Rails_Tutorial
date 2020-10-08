class SessionsController < ApplicationController
  def new
    unless logged_in?
      render 'new'
    else
      user =  User.find_by id: session[:user_id]
      redirect_to user
    end
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "Login success"
      redirect_to user
    else
      #create an error message
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end
  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
