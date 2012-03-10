ActiveAdmin.register_page "Add Auction" do
	content do
		para "Hello World"  
	end
end

ActiveAdmin.register Bid do
  menu :parent => "Advanced"
end

ActiveAdmin.register Auction do
  menu :parent => "Advanced"
end

ActiveAdmin.register User do
  menu :parent => "Advanced"
end