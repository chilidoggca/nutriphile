class NutrientAmount < ApplicationRecord
  scope :get_nutrient_name, -> (nutrient_id_array) {
    joins(:nutrient_names).where("nutrient_names.nutrient_id IN (:nutrients)", nutrients: nutrient_id_array)
  }
  # scope :search_by_tag, -> (tag_array) {
  #   joins(:taggings).where("taggings.tag_id IN (:tags)", tags: tag_array)
  # }
end
