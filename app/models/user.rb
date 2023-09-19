class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum role: {guest: 0, user: 1, manager: 2, admin: 3, super_admin: 4}

  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :images
  has_many :user_messages, dependent: :destroy

  validates :email, presence: true
  validates :role, presence: true

  after_create_commit -> { broadcast_prepend_to "users", partial: "admin/dashboard/users/user", locals: {user: self}, target: "users" }

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
