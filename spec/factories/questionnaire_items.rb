FactoryBot.define do
  factory :questionnaire_item do
    content { Faker::Lorem.paragraph.slice(0, 30) }
    questionnaire
  end
end
