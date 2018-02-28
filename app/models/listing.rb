class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :bookings
  mount_uploaders :listing_images, ListingImagesUploader
end
