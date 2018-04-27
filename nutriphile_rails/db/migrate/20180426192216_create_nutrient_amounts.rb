class CreateNutrientAmounts < ActiveRecord::Migration[5.1]
  def change
    create_table :nutrient_amounts do |t|
      t.integer :food_number
      t.integer :nutrient_number 
      t.float :nutrient_value
      t.integer :standard_error
      t.integer :number_of_observations
      t.integer :nutrient_source_id
      t.date :nutrient_date_of_entry

      t.timestamps
    end
  end
end
