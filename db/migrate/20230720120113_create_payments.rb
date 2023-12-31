# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true
      t.decimal :amount
      t.date :payment_date
      t.string :payment_status

      t.timestamps
    end
  end
end
