class Booking < ApplicationRecord
  belongs_to :guest
  belongs_to :listing
  has_one :host, through: listing
end
