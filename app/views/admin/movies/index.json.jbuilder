json.array! @movies do |movie|
  json.partial! "shared/movie", movie: movie
end
