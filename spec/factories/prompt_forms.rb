FactoryBot.define do
  factory :prompt_form do
    category_id { Faker::Number.between(from: 2, to: 12) }
    title       { Faker::Lorem.word }
    content     { Faker::Lorem.sentence }
    is_public   { 0 }
    group_id    { Faker::Number.between(from: 2, to: 3) }
  end
end
