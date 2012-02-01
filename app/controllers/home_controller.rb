class HomeController < ApplicationController
  def index
  	@auctions = Auctions.all	
  end
end
