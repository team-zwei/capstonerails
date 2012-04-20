class Image < ActiveRecord::Base
	include Rails.application.routes.url_helpers
  mount_uploader :auction_image, AuctionImageUploader

  belongs_to :user

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
