class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:guest, :user, :manager, :admin]

  validates :email, presence: true, uniqueness: true
end
