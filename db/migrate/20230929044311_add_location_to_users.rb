class AddLocationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :location_latitude, :float, default: nil
    add_column :users, :location_longitude, :float, default: nil
  end
end
