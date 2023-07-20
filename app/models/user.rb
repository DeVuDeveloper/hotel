class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { guest: 0, user: 1, manager: 2, admin: 3 }
  
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :email, presence: true
  validates :role, presence: true

  def is_admin?
    admin?
  end

  def is_manager?
    manager?
  end
end

