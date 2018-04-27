class NutrientName < ApplicationRecord
  has_many :nutrient_amounts, through: :nutrients
end
