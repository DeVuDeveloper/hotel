# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user, class: User do
    email { "admin@example.com" }
    password { "password123" }
    role { :admin } # Set the role attribute to "admin" for the admin user
  end
end
