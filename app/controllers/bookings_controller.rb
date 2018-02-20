class BookingsController < ApplicationController
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
    if @booking.save! 
      redirect_to '/listings/'+params[:listing_id]+'/bookings'
    else
      render 'new'
    end
  end

  def show
     @listing = Listing.find(params[:listing_id])
  end



  private

  def booking_params
    # {"first_name"=>"asdf", "last_name"=>"asdf"}
    params.require(:booking).permit(:start_date, :end_date)
  end

end
