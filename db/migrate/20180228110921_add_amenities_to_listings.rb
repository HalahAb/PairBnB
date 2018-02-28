class AddAmenitiesToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :amenities, :integer, default: 0, null: false
  end
end
