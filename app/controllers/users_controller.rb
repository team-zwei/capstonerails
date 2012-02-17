class UsersController < ApplicationController
  skip_before_filter :require_login
  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def show
    redirect_to new_session_path if !current_user
    @current_user
  end
end
