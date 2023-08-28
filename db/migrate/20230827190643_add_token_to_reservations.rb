class AddTokenToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :token, :string
    add_index :reservations, :token
  end
end
