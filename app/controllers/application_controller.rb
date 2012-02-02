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
  	current_user
  	if @current_user
  		Rails.logger.info "current user admin: #{@current_user.admin?}"
  		if @current_user.admin?
  			return @current_user 
  		else
  			redirect_to root_url, notice: "Not accessible"
  		end
  	else
	  	session[:return_to] = request.fullpath
	  	Rails.logger.info "request uri #{request.fullpath}"
	    render "sessions/new"
	end
  end 

  def current_admin_user 
    return nil unless @current_user && current_user.admin?
    Rails.logger.info "current_admin_user current user is #{@current_user.inspect} #{@current_user}"
    @current_user
  end 

end
