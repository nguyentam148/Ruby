class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      remember_login user
    else
      flash.now[:danger] = t ".message"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def remember_login user
    log_in user
    remember_me = params[:session][:remember_me]
    remember_me == Settings.check_box.to_s ? remember(user) : forget(user)
    redirect_to user
  end
end
