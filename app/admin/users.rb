ActiveAdmin.register User do
	filter :id
	filter :username
	filter :email
	filter :created_at
	filter :updated_at
	
  index do
  	column :id
  	column :username
  	column :email
  	column :created_at
  	column :updated_at
    default_actions
  end
end
