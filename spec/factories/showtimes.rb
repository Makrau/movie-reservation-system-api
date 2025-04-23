FactoryBot.define do
  factory :showtime do
    movie
    movie_room
    start_time { 1.day.from_now }
    end_time { start_time + 2.hours }
  end
end
