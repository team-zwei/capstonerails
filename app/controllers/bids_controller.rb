class BidsController < ApplicationController
	respond_to :js, :html
  def new
  end

  def create
  	if current_user
  		
  	else
  		respond_with do |format|
  			format.html {redirect_to login_path, status: 401, alert: "Must be logged in to bid."}
  			format.js {render json: {message: "Must be logged in to bid."}, status: 401}
  		end
  	end
  end
end
