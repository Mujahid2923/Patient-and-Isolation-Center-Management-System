FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    generated_password = Faker::Internet.password
    password { generated_password }
    password_confirmation { generated_password }
  end
end
