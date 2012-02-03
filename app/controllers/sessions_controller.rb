class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    session[:return_to] ||= root_url
  end

  def create
    user = User.find_by_username params[:username]
    user = User.find_by_email params[:username] unless user
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      current_user
      redirect_to destination, notice: "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "Logged out!"
  end
end
