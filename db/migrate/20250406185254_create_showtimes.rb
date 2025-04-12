class CreateShowtimes < ActiveRecord::Migration[8.0]
  def change
    create_table :showtimes, id: :uuid do |t|
      t.references :movie, null: false, foreign_key: true, type: :uuid
      t.references :movie_room, null: false, foreign_key: true, type: :uuid
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps
    end

    add_index :showtimes, [:movie_room_id, :start_time], unique: true
  end
end
