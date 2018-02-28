class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :bookings
  mount_uploaders :listing_images, ListingImagesUploader

  include Bitfields
 
    bitfield :amenities, 
    :parking, 
    :wifi, 
    :disabled_access, 
    :smoking, 
    :kitchen, 
    :pool, 
    :garden, 
    :private_room, 
    :air_conditioning, 
    :event_hosting, 
    :gym, 
    :elevator
end