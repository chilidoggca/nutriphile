class CreateDiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :diaries do |t|
      t.date :diary_date
      t.string :meal_type
      t.string :food_name
      t.float :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
