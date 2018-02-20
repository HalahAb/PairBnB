class ListingsController < ApplicationController
  def index
    @listings =current_user.listings
  end

  def new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save! 
      redirect_to 'users/#{current_user.id}/listings'
    else
      render 'new'
    end
  end

  def show
    @listings = Listing.all
  end


  private

  def listing_params
    # {"first_name"=>"asdf", "last_name"=>"asdf"}
    params.require(:listing).permit(:title, :description)
  end


end
