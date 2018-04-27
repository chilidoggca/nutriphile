class CreateFoodNames < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.integer :food_number
      t.integer :food_code
      t.integer :food_group_id
      t.integer :food_source_id
      t.string :food_name
      t.string :food_name_f
      t.date :food_date_of_entry
      t.date :food_date_of_publication
      t.integer :country_code
      t.string :scientific_name

      t.timestamps
    end
  end
end
