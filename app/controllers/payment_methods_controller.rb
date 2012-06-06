class PaymentMethodsController < ApplicationController
	skip_before_filter :require_admin
  respond_to :html, :json

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
  	
    if @payment_method
      @payment_method.destroy
    	
      respond_with do |f|
        f.html { redirect_to :back }
        f.json { true }
      end
    else
      respond_with do |f|
        f.html { redirect_to :back, alert: 'You are unauthorized to delete that payment method.' }
        f.json { false }
      end
    end
  end
end
