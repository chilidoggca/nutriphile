class CreateNutrients < ActiveRecord::Migration[5.1]
  def change
    create_table :nutrients do |t|
      t.integer :nutrient_number, index: true
      t.references :nutrient_name, foreign_key: true
      t.references :nutrient_amount, foreign_key: true

      t.timestamps
    end
  end
end
