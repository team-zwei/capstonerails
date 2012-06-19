# Create an admin test user
User.create(email: "admin@test.com",
            password: "admin",
            password_confirmation: "admin",
            username: "admin",
            firstname: "Admin",
            lastname: "Runsit"
            )
User.find_by_username("admin").make_admin

# Create a non-admin test user
User.create(email: "test@test.com",
            password: "test",
            password_confirmation: "test",
            username: "test",
            firstname: "Testy",
            lastname: "McTestit"
            )

Category.create(name: "Land", real_estate: true)
Category.create(name: "House", real_estate: true)
Category.create(name: "Equipment", real_estate: false)
Category.create(name: "Electronics", real_estate: false)
Category.create(name: "Automotive", real_estate: false)

time = Time.now + 86400 # setting to one day from current time at seeding.

auction = Auction.create( name: "iPod Touch 32GB",
                description: "A 32GB iPod Touch featuring the latest in Apple iPod Technology.",
                starting_bid_price: 100.00,
                minimum_bid_increment: 5.00,
                end_time: time,
                start_time: Time.now
              )

auction2 = Auction.create( name: "4br 4bath House",
                description: "A charming 4 bedroom, 4 bath house that will be demolished next week.",
                starting_bid_price: 120000.00,
                minimum_bid_increment: 1000.00,
                end_time: time,
                start_time: Time.now,
                data: {
                  bedrooms: "4",
                  bathrooms: "4",
                  "square footage" => "2350"
                }
              )

auction3 = Auction.create( name: "John Deere Tractor",
                description: "It's been said that some women find this tractor sexy. That said, the point is still up for debate.",
                starting_bid_price: 45000.00,
                minimum_bid_increment: 500.00,
                end_time: time,
                start_time: Time.now
              )

Auction.create( name: "Pile of sticks",
                description: "Brand new pile of sticks. No rotting pieces of wood in here.",
                starting_bid_price: 20.00,
                minimum_bid_increment: 5.00,
                end_time: time,
                start_time: Time.now
              )

Auction.create( name: "Nothing",
                description: "The winner of this auction will get absolutely nothing.",
                starting_bid_price: 1.00,
                minimum_bid_increment: 1.00,
                end_time: time,
                start_time: Time.now
              )

Auction.create( name: "Cheesy Poofs",
                description: "Cheetos has nothing on these.",
                starting_bid_price: 2.00,
                minimum_bid_increment: 1.00,
                end_time: time,
                start_time: Time.now
              )

Auction.create( name: "Grandma's lace doilies",
                description: "Great for placing other antiques on top of!",
                starting_bid_price: 238.00,
                minimum_bid_increment: 2.00,
                end_time: time,
                start_time: Time.now
              )

Auction.create( name: "Something",
                description: "The winner of this auction will absolutely get something.",
                starting_bid_price: 3.00,
                minimum_bid_increment: 1.00,
                end_time: time,
                start_time: Time.now
              )

Auction.create( name: "Something Else",
                description: "The winner of this auction will absolutely get something else.",
                starting_bid_price: 1235.00,
                minimum_bid_increment: 15.00,
                end_time: time,
                start_time: Time.now
              )

Auction.create( name: "Something Entirely Different",
                description: "The winner of this auction will absolutely get something entirely different.",
                starting_bid_price: 99.00,
                minimum_bid_increment: 1.00,
                end_time: time,
                start_time: Time.now,
                data: {
                    something: "something value",
                    "different thing" => "different value"
                }
              )


# Give the auctions some categories
Auction.all.each do |auction|
    Category.all.sample(Random.rand(3) + 1).each do |category| 
        auction.categories << category
    end
    auction.save!
end

# Admin wins auction 1
bid = Bid.new(amount: 105.00)
bid.user_id = 1
bid.auction_id = 1
bid.save!

auction.current_bid_id = bid.id
auction.end_time = Time.now - 1
auction.winner_id = 1
auction.save!

# Admin wins auction 2
bid = Bid.new(amount: 121000.00)
bid.user_id = 1
bid.auction_id = 2
bid.save!

auction2.current_bid_id = bid.id
auction2.end_time = Time.now - 1
auction2.winner_id = 1
auction2.save!

# Admin wins auction 3
bid = Bid.new(amount: 45500.00)
bid.user_id = 1
bid.auction_id = 3
bid.save!

auction3.current_bid_id = bid.id
auction3.end_time = Time.now - 1
auction3.winner_id = 1
auction3.save!

# Test bids on auction "Nothing"
bid = Bid.new(amount: 1.00)
bid.user_id = User.find_by_username("test").id
bid.auction_id = Auction.find_by_name("Nothing").id
bid.save!

auction = Auction.find_by_name("Nothing")
auction.current_bid_id = bid.id
auction.save!