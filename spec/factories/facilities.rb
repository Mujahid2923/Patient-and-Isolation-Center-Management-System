FactoryBot.define do
  factory :facility do
    name { Faker::Name.name }
    user
  end
end
