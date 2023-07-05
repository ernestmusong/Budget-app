FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { 'https://avatars.githubusercontent.com/u/1234567?v=4' }
    bio { Faker::Lorem.paragraph }
    posts_counter { 0 }
  end
  factory :post do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    comments_counter { 0 }
    likes_counter { 0 }
    association :author, factory: :user
  end
end
