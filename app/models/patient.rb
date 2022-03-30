class Patient < ApplicationRecord
  belongs_to :facility

  has_many :transfers

  has_one_attached :image

  validates :name,
            presence: true
  validates :cid,
            presence: true
  validates :phone_number,
            presence: true
  validates :joining_date,
            presence: true
  validates :release_date,
            presence: true
  validates :diseases,
            presence: true
  validates :active,
            presence: true
end
