FactoryBot.define do
  factory :tag do
    tag_name   { Faker::Job.key_skill }
    color_code { Faker::Number.between(from: 1, to: 10) }
  end
end
