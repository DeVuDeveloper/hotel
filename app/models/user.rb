class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum role: {guest: 0, user: 1, manager: 2, admin: 3, super_admin: 4}

  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :image

  validates :email, presence: true
  validates :role, presence: true

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
