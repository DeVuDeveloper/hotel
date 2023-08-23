class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars do |t|
      t.references :room, null: false, foreign_key: true
      t.date :date
      t.decimal :price
      t.boolean :available

      t.timestamps
    end
  end
end
