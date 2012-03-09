class BidsController < ApplicationController
  skip_before_filter :require_login, only: [:create]
	respond_to :json, :html

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
      bid.auction.end_time += 600 # ten minutes #TODO add time to end_time appropriately

      # get current bid to verify amount
      cbid = Bid.find_by_id(bid.auction.current_bid_id)
      inc = bid.auction.minimum_bid_increment

      if bid.amount < cbid.amount + inc
        response = 'minimum bid not met'
        status_code = 412 # precondition failed HTTP response
      elsif bid.save! && bid.auction.save!
        bid.auction.current_bid_id = bid.id
        bid.auction.save!
        
        PrivatePub.publish_to "/bids/new", message: { auction_id: bid.auction_id, time: bid.auction.get_remaining_time, amount: bid.amount }
        response = 'success'
        status_code = 200
      else
        response = 'failure'
        status_code = 400
      end
      
      respond_with do |format|
        format.html {redirect_to root_url, status: status_code, notice: response}
        format.json {render json: {message: response}, status: status_code}
      end
  	else
      Rails.logger.info "TESTING TESTING TESTING ==========================="
  		respond_with do |format|
  			format.html {redirect_to login_path, status: 401, alert: "Must be logged in to bid."}
  			format.json {render json: {message: "Must be logged in to bid."}, status: 401}
  		end
  	end
  end
end
