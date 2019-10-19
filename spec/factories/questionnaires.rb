FactoryBot.define do
  factory :questionnaire do
    theme { Faker::Lorem.sentence }
    category { Faker::Lorem.paragraph }
    user
  end
end
