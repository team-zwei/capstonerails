class PaymentsController < ApplicationController
  def new
  	@payment = Payment.new
  	@auction_id = params[:auction_id]
  end

  def create
  end

  def show
  end

  def index
  end
end
