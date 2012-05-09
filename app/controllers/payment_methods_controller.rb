class PaymentMethodsController < ApplicationController
	skip_before_filter :require_admin

  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def destroy
  	@payment_method = current_user.payment_methods.find_by_id(params[:id])
  	@payment_method.destroy if @payment_method
  	render :json => true
  end
end
