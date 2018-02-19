class DropHostAndGuestTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :guests
    drop_table :hosts
  end
end
