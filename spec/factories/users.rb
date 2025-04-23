FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "Password123!@#" }
  end
end
