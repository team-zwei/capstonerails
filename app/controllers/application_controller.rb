class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :authenticate_admin_user!
  helper_method :current_admin_user


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
    render "sessions/new"
  end 

  def current_admin_user 
    return nil unless @current_user && current_user.admin?
    @current_user
  end 

end
