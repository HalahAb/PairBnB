class ReservationMailer < ApplicationMailer

  default from: 'halah.dev@gmail.com'

  def reservation_email(guest, host, booking_id)
  @guest = guest
  @host = host
  @booking_id = booking_id
  @url  = 'http://localhost:3000/sign_in'
  mail(to: @guest.email, subject: 'Your booking was sucessful!')
  end
end
