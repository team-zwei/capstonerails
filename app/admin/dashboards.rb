ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

  section "Recent Bids", :priority => 1 do
    table_for Bid.order("created_at desc").limit(5) do
      column :id
      column :amount
      column "Auction ID", :auction_id do |bid|
        link_to bid.auction_id, admin_auction_path(bid.auction_id)
      end
      column "User ID", :user_id do |bid|
        link_to bid.user_id, admin_user_path(bid.user_id)
      end
      column :username do |bid|
        link_to User.find_by_id(bid.user_id).username, admin_user_path(bid.user_id)
      end 
      column :updated_at
      column :created_at
    end
  end

  section "Recent Auctions", :priority => 2 do
    table_for Auction.order("created_at desc").limit(5) do
      column :id
      column :name do |auction|
        link_to auction.name, admin_auction_path(auction)
      end
      column :created_at
    end
    strong { link_to "View All Auctions", admin_auctions_path }
  end

  section "Recent Users", :priority => 3 do
    table_for User.order("created_at desc").limit(5) do
      column :id
      column :username do |user|
        link_to user.username, admin_user_path(user)
      end
      column :created_at
    end
    strong { link_to "View All Users", admin_users_path }
  end

  section "Recent Payments", :priority => 4 do
    table_for Payment.order("created_at desc").limit(5) do
      column :id
      column :user_id do |user|
        link_to user.username, admin_user_path(user)
      end
      column :auction_id do |auction|
        link_to auction.name, admin_auction_path(auction)
      end
      column :created_at
    end
    strong { link_to "View All Payments", admin_payments_path }
  end
  
end
