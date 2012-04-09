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

time = Time.now + 86400 # setting to one day from current time at seeding.

auction = Auction.create( name: "iPod Touch 32GB",
                description: "A 32GB iPod Touch featuring the latest in Apple iPod Technology.",
                starting_bid_price: 100.00,
                minimum_bid_increment: 5.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=iPod+Touch+32GB+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=iPod+Touch+32GB+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=iPod+Touch+32GB+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=iPod+Touch+32GB+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=iPod+Touch+32GB+image5",
                            title: "image5"
                          }
                }
              )

Auction.create( name: "4br 4bath House",
                description: "A charming 4 bedroom, 4 bath house that will be demolished next week.",
                starting_bid_price: 120000.00,
                minimum_bid_increment: 1000.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=4br+4bath+House+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=4br+4bath+House+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=4br+4bath+House+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=4br+4bath+House+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=4br+4bath+House+image5",
                            title: "image5"
                          }
                }
              )

Auction.create( name: "John Deere Tractor",
                description: "It's been said that some women find this tractor sexy. That said, the point is still up for debate.",
                starting_bid_price: 45000.00,
                minimum_bid_increment: 500.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=John+Deere+Tractor+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=John+Deere+Tractor+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=John+Deere+Tractor+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=John+Deere+Tractor+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=John+Deere+Tractor+image5",
                            title: "image5"
                          }
                }
              )

Auction.create( name: "Pile of sticks",
                description: "Brand new pile of sticks. No rotting pieces of wood in here.",
                starting_bid_price: 20.00,
                minimum_bid_increment: 5.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=Pile+of+sticks+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=Pile+of+sticks+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=Pile+of+sticks+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=Pile+of+sticks+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=Pile+of+sticks+image5",
                            title: "image5"
                          }
                }
              )

Auction.create( name: "Nothing",
                description: "The winner of this auction will get absolutely nothing.",
                starting_bid_price: 1.00,
                minimum_bid_increment: 1.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=Nothing+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=Nothing+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=Nothing+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=Nothing+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=Nothing+image5",
                            title: "image5"
                          }
                }
              )

Auction.create( name: "Cheesy Poofs",
                description: "Cheetos has nothing on these.",
                starting_bid_price: 2.00,
                minimum_bid_increment: 1.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=Cheesy+Poofs+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=Cheesy+Poofs+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=Cheesy+Poofs+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=Cheesy+Poofs+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=Cheesy+Poofs+image5",
                            title: "image5"
                          }
                }
              )

Auction.create( name: "Grandma's lace doilies",
                description: "Great for placing other antiques on top of!",
                starting_bid_price: 238.00,
                minimum_bid_increment: 2.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=Grandmas+lace+doilies+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=Grandmas+lace+doilies+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=Grandmas+lace+doilies+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=Grandmas+lace+doilies+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=Grandmas+lace+doilies+image5",
                            title: "image5"
                          }
                }
              )

Auction.create( name: "Something",
                description: "The winner of this auction will absolutely get something.",
                starting_bid_price: 3.00,
                minimum_bid_increment: 1.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=Something+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=Something+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=Something+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=Something+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=Something+image5",
                            title: "image5"
                          }
                }
              )

Auction.create( name: "Something Else",
                description: "The winner of this auction will absolutely get something else.",
                starting_bid_price: 1235.00,
                minimum_bid_increment: 15.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=Something+Else+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=Something+Else+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=Something+Else+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=Something+Else+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=Something+Else+image5",
                            title: "image5"
                          }
                }
              )

Auction.create( name: "Something Entirely Different",
                description: "The winner of this auction will absolutely get something entirely different.",
                starting_bid_price: 99.00,
                minimum_bid_increment: 1.00,
                end_time: time,
                image_urls: {
                    image1: { url: "http://placehold.it/400x300&text=Something+Entirely+Different+main",
                            title: "Main image",
                            main: "true"
                          },
                    image2: { url: "http://placehold.it/400x300&text=Something+Entirely+Different+image2",
                            title: "image2"
                          },
                    image3: { url: "http://placehold.it/400x300&text=Something+Entirely+Different+image3",
                            title: "image3"
                          },
                    image4: { url: "http://placehold.it/400x300&text=Something+Entirely+Different+image4",
                            title: "image4"
                          },
                    image5: { url: "http://placehold.it/400x300&text=Something+Entirely+Different+image5",
                            title: "image5"
                          }
                    },
                data: {
                    something: "something value",
                    "different thing" => "different value"
                }
              )

bid = Bid.new(amount: 105.00)
bid.user_id = 1
bid.auction_id = 1
bid.save!

auction.current_bid_id = bid.id
auction.end_time = Time.now - 1
auction.winner_id = 1
auction.save!

bid = Bid.new(amount: 1.00)
bid.user_id = User.find_by_username("test").id
bid.auction_id = Auction.find_by_name("Nothing").id
bid.save!

auction = Auction.find_by_name("Nothing")
auction.current_bid_id = bid.id
auction.save!