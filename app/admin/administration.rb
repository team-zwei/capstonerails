ActiveAdmin.register Bid do
  menu :parent => "Advanced"
end

ActiveAdmin.register Auction do
  form :partial => "form"
  menu :parent => "Advanced"
end

ActiveAdmin.register User do
  menu :parent => "Advanced"
end

ActiveAdmin.register Payment do
	menu :parent => "Advanced"
end