class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :guest, class_name: 'User'
  has_one :host, through: :listing
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :uniqueness_of_date_range

  before_save :set_total_price

  def calculate_date_difference
    (self.end_date - self.start_date).to_i
  end

  def set_total_price
    self.total_price =calculate_date_difference * self.listing.price 
  end




  private
  def uniqueness_of_date_range
    errors.add(:start_date, "Booking unavailable, Start date overlaps with existing booking. Please choose another date.") unless Booking.where("? >= start_date AND ? <= end_date",
                                                            start_date, start_date).count == 0
    errors.add(:end_date,"Booking unavailable, end date overlaps with existing booking. Please choose another date." ) unless Booking.where("? >= start_date AND ? <= end_date",
                                                            end_date, end_date).count == 0
    errors.add(:base, "Booking unavailable, start date and end date overlap with existing booking. Please choose another date.") unless Booking.where("? <= start_date AND ? >= end_date",
                                                            start_date, end_date).count == 0
  end

end
