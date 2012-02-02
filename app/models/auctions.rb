# == Schema Information
#
# Table name: auctions
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :string(255)
#  start_time  :datetime
#  end_time    :datetime
#

class Auctions < ActiveRecord::Base
end
