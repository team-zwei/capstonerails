ActiveAdmin.register Bid do
  menu :parent => "Advanced"
end

ActiveAdmin.register Auction do
  menu :parent => "Advanced"
  form :partial => "form"
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