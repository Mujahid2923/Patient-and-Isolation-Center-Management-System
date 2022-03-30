class Facility < ApplicationRecord
  has_many :patients
  belongs_to :user

  validates :name,
            presence: true
end
