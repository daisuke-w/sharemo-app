FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    profile               { Faker::Lorem.sentence }
    group_id              { Faker::Number.between(from: 2, to: 3) }

    after(:build) do |item|
      item.user_image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
