class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :facilities
  has_many :announcements
  has_many :transfers
end
