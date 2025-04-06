class CreateMovieRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :movie_rooms, id: :uuid do |t|
      t.integer :number, null: false
      t.integer :total_seats, null: false

      t.timestamps
    end

    add_index :movie_rooms, :number, unique: true
  end
end
