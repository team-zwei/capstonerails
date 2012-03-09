class UsersController < ApplicationController
  skip_before_filter :require_login
  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def show
    redirect_to new_session_path if !current_user
    @active_auctions = current_user.auctions.where("end_time > now()").page(params[:page]).per(8)
    # @won_auctions = current_user.auctions
    # @lost_auctions = current_user.auctions

    @current_user
  end
end
