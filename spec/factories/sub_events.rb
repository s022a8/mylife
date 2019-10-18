FactoryBot.define do
  factory :sub_event do
    part { Faker::Lorem.paragraph }
    detail { Faker::Lorem.sentence }
    history
  end
end
