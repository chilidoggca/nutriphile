class CreateNutrientNames < ActiveRecord::Migration[5.1]
  def change
    create_table :nutrient_names do |t|
      t.integer :nutrient_number
      t.integer :nutrient_code
      t.string :nutrient_symbol
      t.string :nutrient_unit
      t.string :nutrient_name
      t.string :nutrient_name_f
      t.string :tagname
      t.integer :nutrient_decimals

      t.timestamps
    end
  end
end
