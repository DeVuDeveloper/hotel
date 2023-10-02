# frozen_string_literal: true

class CreateCalendarEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :calendar_entries do |t|
      t.references :calendar, null: false, foreign_key: true
      t.date :date
      t.integer :price
      t.boolean :available

      t.timestamps
    end
  end
end
