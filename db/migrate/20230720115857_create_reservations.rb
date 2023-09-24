class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :number_of_guests
      t.decimal :total_price
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end

    add_index :reservations, :token
  end
end
