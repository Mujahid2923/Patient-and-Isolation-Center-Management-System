FactoryBot.define do
  factory :patient do
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number }
    joining_date { Faker::Date.between(from: Date.today, to: 10.year.from_now) }
    release_date { Faker::Date.between(from: Date.today, to: 10.year.from_now) }
    diseases { 'Fever' }
    cid { 1 }
    active { 1 }
  end
end
