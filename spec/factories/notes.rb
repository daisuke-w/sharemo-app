FactoryBot.define do
  factory :note do
    category_id { Faker::Number.between(from: 2, to: 12) }
    title       { Faker::Lorem.word }
    content     { Faker::Lorem.sentence }
    is_public   { 0 }
    association :user
    association :prompt
  end
end
