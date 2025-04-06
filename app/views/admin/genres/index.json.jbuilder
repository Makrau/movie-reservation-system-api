json.array! @genres do |genre|
  json.partial! "shared/genre", genre: genre
end 