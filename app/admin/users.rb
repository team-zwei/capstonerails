ActiveAdmin.register User do
  index do
  	column :id
  	column :username
  	column :email
  	column :created_at
  	column :updated_at
  end
end
