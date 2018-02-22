class BookingsController < ApplicationController
  before_action :require_login, only: [:create,:index,:show]
  #shows all bookings for the logged in guest
  def index
    
    @bookings =current_user.bookings


  end

  #shows a form to add a booking for the list_id in the url.
  def new
    @listing = Listing.find(params[:listing_id])
  end

  #submits the new booking dates for the signed in user to the db
  def create
    @booking = current_user.bookings.new(booking_params)
    @booking.listing_id = params[:listing_id]
    
    if @booking.save 
      redirect_to '/listings/'+params[:listing_id]+'/bookings'
    else
      @listing = Listing.find(params[:listing_id])
      @booking_error = true
  
      render 'new'
    end
  end

  def show
     @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = current_user.bookings.find(params[:id])
    if @booking.destroy
      redirect_to listing_bookings_path
      else
      'This booking does not exist'
    end
  end


  private

  def booking_params
    # {"first_name"=>"asdf", "last_name"=>"asdf"}
    params.require(:booking).permit(:start_date, :end_date)
  end

end
