# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :role, default: 0, null: false
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :unsubscribe_token
      t.boolean :subscribed
      t.string :uid
      t.string :provider

      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :unsubscribe_token, unique: true
  end
end
