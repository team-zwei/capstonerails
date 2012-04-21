ActiveAdmin.register Bid do
  menu :parent => "Advanced"
end

ActiveAdmin.register Auction do
  form :partial => "form"
  menu :parent => "Advanced"

  controller do
    layout 'active_admin'
    def new
      @page_title = "New Auction: Step 1 of 3"
      @auction = Auction.new
    end

    def create
      @auction = params[:auction]
      render 'admin/auctions/image_form'
    end



  end
end

ActiveAdmin.register User do
  menu :parent => "Advanced"
end

ActiveAdmin.register Payment do
	menu :parent => "Advanced"
end

ActiveAdmin.register PaymentMethod do
	menu :parent => "Advanced"
end

ActiveAdmin.register Image do
	menu :parent => "Advanced"
end