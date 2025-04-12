json.extract! showtime, :id, :start_time, :end_time, :created_at, :updated_at
json.movie do
  json.partial! 'shared/movie', movie: showtime.movie
end
json.movie_room do
  json.partial! 'shared/movie_room', movie_room: showtime.movie_room
end 