# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: {guest: 0, user: 1, manager: 2, admin: 3, super_admin: 4}

  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :images
  has_many :user_messages, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :notification_messages
  has_many :newsletters

  validates :email, presence: true
  validates :role, presence: true

  after_create_commit lambda {
                        broadcast_prepend_to "users", partial: "admin/dashboard/users/user", locals: {user: self},
                          target: "users"
                      }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def is_superadmin?
    role == "super_admin"
  end

  def is_admin?
    admin?
  end

  def is_manager?
    manager?
  end
end
