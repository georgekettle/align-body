class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :video_url
      t.references :category, null: false, foreign_key: true
      t.references :instructor, null: false, foreign_key: true
      t.integer :difficulty, null: false, default: 0
      t.integer :mins

      t.timestamps
    end
  end
end
