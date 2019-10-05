FactoryBot.define do
  factory :comment do
    user_id { 1 }
    history_id { 1 }
    body { "MyString" }
  end
end
