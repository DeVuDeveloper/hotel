class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :contact

      t.timestamps
    end
  end
end
