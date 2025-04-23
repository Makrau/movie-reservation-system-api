FactoryBot.define do
  factory :movie_room do
    sequence(:number) { |n| n }
    total_seats { rand(50..200) }
  end
end
