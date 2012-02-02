# Create an admin test user
User.create(email: "admin@test.com", password: "admin", password_confirmation: "admin", username: "admin")
User.find_by_username("admin").make_admin

# Create a non-admin test user
User.create(email: "test@test.com", password: "test", password_confirmation: "test", username: "test")
