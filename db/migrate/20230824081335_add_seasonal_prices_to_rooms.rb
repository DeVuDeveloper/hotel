class AddSeasonalPricesToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :summer_price, :decimal
    add_column :rooms, :winter_price, :decimal
    add_column :rooms, :spring_price, :decimal
    add_column :rooms, :autumn_price, :decimal
  end
end
