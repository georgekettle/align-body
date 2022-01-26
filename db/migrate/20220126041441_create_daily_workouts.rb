class CreateDailyWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_workouts do |t|
      t.date :date
      t.references :workout, null: false, foreign_key: true

      t.timestamps
    end
  end
end
