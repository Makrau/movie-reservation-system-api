FactoryBot.define do
  factory :seat do
    association :movie_room
    row_number { rand(1..10) }
    column_number { rand(1..15) }
    label { "#{('A'..'Z').to_a[row_number-1]}#{column_number}" }
    seat_type { %w[regular wheelchair couple].sample }
  end
end
