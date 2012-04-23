class ImagesController < ApplicationController
  def index
    @images = Image.all
    render :json => @images.collect { |p| p.to_jq_upload }.to_json
  end

  def new
    @image = Image.new
    @auction = Auction.find_by_id params[:auction_id]
  end

  def create
    @image = Image.new params[:image]
    @image.auction_id = Auction.find_by_id(params[:auction_id]).id
    if @image.save
      Rails.logger.info(@image.auction_id)
      respond_to do |format|
        format.html {  
          render :json => [@image.to_jq_upload].to_json, 
          :content_type => 'text/html',
          :layout => false
        }
        format.json {  
          render :json => [@image.to_jq_upload].to_json			
        }
      end
    else 
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render :json => true
  end
end
