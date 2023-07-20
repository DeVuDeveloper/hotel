class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :room_type
      t.integer :number_of_beds
      t.decimal :price_per_night
      t.text :description
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
