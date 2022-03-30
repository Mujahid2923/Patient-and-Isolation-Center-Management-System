class Transfer < ApplicationRecord
  belongs_to :patient

  validates :transfered_facility,
            presence: true

  validates :date,
            presence: true
end
