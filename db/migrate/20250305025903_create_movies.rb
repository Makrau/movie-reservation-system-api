class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies, id: :uuid do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :poster_image_url

      t.timestamps
    end
  end
end
