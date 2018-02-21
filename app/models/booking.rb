class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :guest, class_name: 'User'
  has_one :host, through: :listing


  validate :uniqueness_of_date_range
  private
  def uniqueness_of_date_range
    errors.add(:start_date, "Booking unavailable, overlaps with existing booking. Please choose another date.") unless Booking.where("? >= start_date AND ? <= end_date",
                                                            start_date, start_date).count == 0
    errors.add(:end_date,"Booking unavailable, overlaps with existing booking. Please choose another date." ) unless Booking.where("? >= start_date AND ? <= end_date",
                                                            end_date, end_date).count == 0
    errors.add(:end_date, "Booking unavailable, overlaps with existing booking. Please choose another date.") unless Booking.where("? <= start_date AND ? >= end_date",
                                                            start_date, end_date).count == 0
  end

end