class CreateJoinTableMovieGenre < ActiveRecord::Migration[8.0]
  def change
    create_join_table :movies, :genres, column_options: { type: :uuid } do |t|
      t.index [:movie_id, :genre_id], unique: true
    end
  end
end
