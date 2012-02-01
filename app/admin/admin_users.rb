ActiveAdmin.register AdminUser do
  index do
  	column :id
  	column :email
  	column :reset_password_sent_at
  	column :remember_created_at
  	column :current_sign_in_at
  	column :last_sign_in_at
  	column :last_sign_in_ip
  	column :created_at
  	column :updated_at
  end
end
