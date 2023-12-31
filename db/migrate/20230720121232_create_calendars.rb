# frozen_string_literal: true

class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars do |t|
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
