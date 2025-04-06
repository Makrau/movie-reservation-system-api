json.array! @movie_rooms do |movie_room|
  json.partial! "shared/movie_room", movie_room: movie_room
end 