FactoryBot.define do
  factory :announcement do
    title { Faker::Hipster.sentence(word_count: 3) }
    description { Faker::Hipster.paragraph }
  end
end
