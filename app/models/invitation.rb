class Invitation < ApplicationRecord
  include Resources::RegexValidation

  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX }
end
