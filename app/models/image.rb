# == Schema Information
#
# Table name: images
#
#  id            :integer         not null, primary key
#  auction_image :string(255)
#  auction_id    :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Image < ActiveRecord::Base
	include Rails.application.routes.url_helpers
  mount_uploader :auction_image, AuctionImageUploader

  attr_accessible :auction_image

  belongs_to :user
  belongs_to :auction

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
      "id" => read_attribute(:id),
      "size" => auction_image.size,
      "url" => auction_image.url,
      "thumbnail_url" => auction_image.thumb.url,
      "delete_url" => image_path(:id => id),
      "delete_type" => "DELETE" 
    }
  end
end
