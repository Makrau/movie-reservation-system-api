json.array! @movies do |movie|
  json.partial! "movies/movie", movie: movie
end
