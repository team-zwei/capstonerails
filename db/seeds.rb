# Create an admin test user
User.create(email: "admin@test.com", password: "admin", password_confirmation: "admin", username: "admin", firstname: "Admin", lastname: "Runsit")
User.find_by_username("admin").make_admin

# Create a non-admin test user
User.create(email: "test@test.com", password: "test", password_confirmation: "test", username: "test", firstname: "Testy", lastname: "McTestit")


Auction.create(name: "iPod Touch 32GB", description: "A 32GB iPod Touch featuring the latest in Apple iPod Technology.")
Auction.create(name: "4br 4bath House", description: "A charming 4 bedroom, 4 bath house that will be demolished next week.")
Auction.create(name: "John Deere Tractor", description: "It's been said that some women find this tractor sexy. That said, the point is still up for debate.")
Auction.create(name: "Pile of sticks", description: "Brand new pile of sticks. No rotting pieces of wood in here.")
Auction.create(name: "Nothing", description: "The winner of this auction will get absolutely nothing.")
Auction.create(name: "Cheesy Poofs", description: "Cheetos has nothing on these.")
Auction.create(name: "Grandma's lace doilies", description: "Great for placing other antiques on top of!")

bid = Bid.new(amount: 100.00); bid.user_id = User.find_by_username("test").id; bid.auction_id = Auction.find_by_name("Nothing").id; bid.save!