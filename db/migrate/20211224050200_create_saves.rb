class CreateSaves < ActiveRecord::Migration[7.0]
  def change
    create_table :saves do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
