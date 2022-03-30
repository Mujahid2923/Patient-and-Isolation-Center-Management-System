module Resources
  module RegexValidation
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    VALID_USERNAME_REGEX = /\A[a-zA-Z0-9_]+\Z/
  end
end
