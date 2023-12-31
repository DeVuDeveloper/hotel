# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "superadmin@example.com" }
    password { "password" }
    role { "super_admin" }
  end
end
