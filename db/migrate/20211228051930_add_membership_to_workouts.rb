class AddMembershipToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :membership, :boolean, null: false, default: true
  end
end
