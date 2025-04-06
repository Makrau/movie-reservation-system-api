json.(movie, :id, :title, :description, :poster_image_url, :created_at, :updated_at)
json.genres do
  json.array! movie.genres.pluck(:genre)
end