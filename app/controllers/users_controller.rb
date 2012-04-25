class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  skip_before_filter :require_admin
  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, notice: "Signed up!"
    else
      render "new"
    end
  end

  def show
    auctions = @current_user.auctions
    active_auctions = auctions.where "end_time > now()"
    won_auctions    = auctions.where "winner_id = #{@current_user.id}"
    lost_auctions   = auctions.where "winner_id != #{@current_user.id}"

    @active_auctions = active_auctions.page(params[:page]).per(8)
    @won_auctions = won_auctions.page(params[:page]).per(8)
    @lost_auctions = lost_auctions.page(params[:page]).per(8)

    @bids = @current_user.bids

    @current_user
  end
end
