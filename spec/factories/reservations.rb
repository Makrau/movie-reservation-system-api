FactoryBot.define do
  factory :reservation do
    user
    showtime
    sequence(:seat_number) { |n| n }
  end
end
