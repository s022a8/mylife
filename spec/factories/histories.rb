FactoryBot.define do
  factory :history do
    user_id { 1 }
    age { 1 }
    event { "MyString" }
    barometer { 1 }
  end
end
