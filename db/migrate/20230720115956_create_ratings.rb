# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :hotel, null: false, foreign_key: true
      t.float :average_rating

      t.timestamps
    end
  end
end
