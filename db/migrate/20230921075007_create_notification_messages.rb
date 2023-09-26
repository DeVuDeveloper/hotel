# frozen_string_literal: true

class CreateNotificationMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_messages do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
