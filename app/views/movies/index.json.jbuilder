json.array! @movies do |movie|
  json.partial! "movies/movie", movie: movie
  json.genres do
    json.array! movie.genres.pluck(:genre)
  end
end
