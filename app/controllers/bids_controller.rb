class BidsController < ApplicationController
	respond_to :js, :html

  def index
  end

  def new
  end

  def create
  	if current_user
      # TODO: min bid met?
  		bid = Bid.new amount: Float(params[:bid_amount][/\d+(.\d{2})?/])
      bid.user_id = current_user.id
      bid.auction_id = params[:id] || params[:auction_id]
      if bid.save!
        message = { auction_id: bid.auction_id, time: bid.auction.get_remaining_time }
        PrivatePub.publish_to("/bids/new", message)
        response = 'success'
      else
        response = 'failure'
      end
      
      respond_with do |format|
        format.html {redirect_to root_url, status: 200, notice: response}
        format.js {render json: {message: response}, status: 200}
      end
  	else
  		respond_with do |format|
  			format.html {redirect_to login_path, status: 401, alert: "Must be logged in to bid."}
  			format.js {render json: {message: "Must be logged in to bid."}, status: 401}
  		end
  	end
  end
end
