FactoryBot.define do
  factory :todo do
    title { "MyString" }
    description { "MyText" }
    completed { false }
    priority { 1 }
    due_date { "2026-01-11" }
    user_id { "" }
  end
end
