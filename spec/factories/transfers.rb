FactoryBot.define do
  factory :transfer do
    date { Faker::Date.between(from: Date.today, to: 10.year.from_now) }
  end
end
