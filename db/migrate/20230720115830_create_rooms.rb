class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name, default: ""
      t.string :room_type, default: "Standard"
      t.integer :number_of_beds, default: 1
      t.decimal :price_per_night, default: 0.0
      t.text :description, default: ""
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
