class NutrientAmount < ApplicationRecord
  has_many :nutrient_names, through: :nutrients

  scope :get_nutrient_name, -> (nutrient_id_array) {
    joins(:nutrient_names).where("nutrient_names.nutrient_id IN (:nutrients)", nutrients: nutrient_id_array)
  }
end
