class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :authenticate_admin_user!
  helper_method :current_admin_user
  helper_method :logged_in?

  before_filter :require_login, :require_admin

  # Override build_footer method in ActiveAdmin::Views::Pages
  require 'active_admin_views_pages_base.rb'

  def destination
    url = session[:return_to] || root_url
    session[:return_to] = nil
    url
  end

  private

  def current_user
    @current_user ||= User.find_by_auth_token( cookies[:auth_token] ) if cookies[:auth_token]
  end

  def authenticate_admin_user!
  	if current_user
		return @current_user if @current_user.admin?
		redirect_to root_url, notice: "Not accessible" and return
  	end
  	session[:return_to] = request.fullpath
    render "sessions/new", layout: "application"
  end 

  def current_admin_user
    return nil unless current_user && current_user.admin?
    @current_user
  end

  def require_login
    unless logged_in?
      #session[:return_to] = request.fullpath
      render "sessions/new", alert: "You must be logged in to access this section"
    end
  end

  def require_admin
    #TODO Error flash isn't showing
    redirect_to root_url, alert: "Insufficient Privileges" unless current_admin_user
    @current_user
  end
 
  def logged_in?
    !!current_user
  end

  def require_auction_token
    unless (auction = Auction.find_by_id(params[:id])) && auction.token == session[:auction_token]
      redirect_to new_auction_path, alert: "Error creating auction! Please try again. If this persists, contact customer support."
    end
  end

end
