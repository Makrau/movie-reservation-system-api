FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    description { Faker::Lorem.paragraph }
    poster_image_url { Faker::Internet.url }
  end
end
