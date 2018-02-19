class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :listing_id
      t.integer :guest_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
