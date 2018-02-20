class ListingsController < ApplicationController
  # show current user's listings
  def index
    @listings =current_user.listings
  end

  # show a form to create a new listing
  def new
  end

  # post and save a new listing to current user
  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save! 
      redirect_to '/listings'
    else
      render 'new'
    end
  end

  def edit
    @listing = current_user.listings.find(params[:id])
  end



  def update
    @listing = current_user.listings.find(params[:id])
 
    @listing.update(listing_params)
    redirect_to listings_path
  end





  # show a listing by id
  def show
    @listing = Listing.find(params[:id])
  end

  
  private

  def listing_params
    # {"first_name"=>"asdf", "last_name"=>"asdf"}
    params.require(:listing).permit(:title, :description)
  end


end
