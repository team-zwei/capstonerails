class BidsController < ApplicationController
	def create
		render json: params[:bid];
	end
end
