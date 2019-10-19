FactoryBot.define do
  factory :history do
    age { Faker::Number.between(from: 1, to: 100) }
    event { Faker::Lorem.sentence }
    barometer { Faker::Number.between(from: 1, to: 100) }
    user
  end
end
