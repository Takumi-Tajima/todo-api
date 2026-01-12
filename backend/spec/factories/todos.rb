FactoryBot.define do
  factory :todo do
    content { Faker::Lorem.sentence }
  end
end
