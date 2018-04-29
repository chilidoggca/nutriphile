class CreateDiaryEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :diary_entries do |t|
      t.date :diary_date
      t.string :meal_type
      t.string :food_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
