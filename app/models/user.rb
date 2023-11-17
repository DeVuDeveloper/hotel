# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum role: {user: 0, guest: 1, manager: 2, admin: 3, super_admin: 4}

  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :images
  has_many :user_messages, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :notification_messages
  has_many :newsletters
  has_many :likes, dependent: :destroy
  has_many :liked_rooms, through: :likes, source: :room

  validates :email, presence: true
  validates :role, presence: true

  after_create_commit lambda {
                        broadcast_prepend_to "users", partial: "admin/dashboard/users/user", locals: {user: self},
                          target: "users"
                      }



  def is_superadmin?
    role == "super_admin"
  end

  def is_admin?
    admin?
  end

  def is_manager?
    manager?
  end

  def likes_room?(room)
    liked_rooms.include?(room)
  end

  def like(room)
    liked_rooms << room unless likes_room?(room)
  end

  def unlike(room)
    liked_rooms.delete(room) if likes_room?(room)
  end
end
