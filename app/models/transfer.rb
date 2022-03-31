class Transfer < ApplicationRecord
  validates :to_facility,
            presence: true
  validates :date,
            presence: true
end
