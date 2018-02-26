class BookingsController < ApplicationController
  before_action :require_login, only: [:create,:index,:show,:user_bookings, :pay, :submit_pay]
  
  def user_bookings

    @bookings =current_user.bookings

  end

  #shows all bookings for the logged in guest
  def index
    @listing = Listing.find(params[:listing_id])
    @bookings =@listing.bookings
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
      redirect_to '/listings/'+params[:listing_id]+'/bookings'+'/'+ @booking.id.to_s+'/new_payment'
    else
      @listing = Listing.find(params[:listing_id])
      @booking_error = true
  
      render 'new'
    end
  end

  def show
     @booking = Booking.find(params[:id])
  end

 def pay
     @client_token = Braintree::ClientToken.generate
     @booking = Booking.find(params[:id])
  end

  def submit_payment
    # ??
    @booking = current_user.bookings.where([ "id = ?", params[:id] ]).first
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => @booking.total_price, #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      redirect_to listing_booking_path, :flash => { :success => "Transaction successful!" }
    else
      redirect_to listing_booking_path, :flash => { :error => "Transaction failed. Please try again." }
    end
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
