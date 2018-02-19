class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.integer :host_id
      t.string :title
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
