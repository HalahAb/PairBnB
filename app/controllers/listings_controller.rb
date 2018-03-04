class ListingsController < ApplicationController

  before_action :require_login, only: [:create,:update,:destroy,:user_listings]
  
  # show current user's listings
  def user_listings
    @listings =current_user.listings
  end
 
  def index
    @listings =Listing.all
    # @listings =current_user.listings
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

  def destroy
    @listing = current_user.listings.find(params[:id])
    if @listing.destroy
      redirect_to '/listings'
      else
      'This listing does not exist'
    end

  end


  # show a listing by id
  def show
    @listing = Listing.find(params[:id])
    @amenities = @listing.bitfield_values(:amenities).select{|key,value| value == true }
  end

  
  def search
    @listings = Listing.where("location ILIKE :search_term OR title ILIKE :search_term", search_term: "%#{params[:search_term].downcase}%")

    if filtering_params['amenities'].present?
      filtering_params['amenities'].each do |key, value|
        @listings = @listings.public_send(key) if value == '1'
      end
    end

    render 'index'
    # redirect_to '/listings'

  end

  
  private

    def listing_params
      # {"first_name"=>"asdf", "last_name"=>"asdf"}
      params.require(:listing).permit(:title, :description,:price,:location, {listing_images: []},:parking, 
      :wifi, 
      :disabled_access, 
      :smoking, 
      :kitchen, 
      :pool, 
      :garden, 
      :private_room, 
      :airconditioning, 
      :event_hosting, 
      :gym, 
      :elevator)
    end

    def filtering_params
      params.slice('amenities')
    end


  end
