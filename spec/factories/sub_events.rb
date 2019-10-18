FactoryBot.define do
  factory :sub_event do
    part { Faker::Lorem.paragraph.slice(0, 15) }
    detail { Faker::Lorem.sentence }
    history
  end
end
