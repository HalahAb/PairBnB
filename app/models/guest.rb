class Guest < ApplicationRecord
  has_many :bookings, :foreign_key => :booking_id
end
