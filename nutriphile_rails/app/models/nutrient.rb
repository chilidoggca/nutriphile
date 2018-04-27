class Nutrient < ApplicationRecord
  belongs_to :nutrient_name
  belongs_to :nutrient_amount
  belongs_to :food

  validates :nutrient_name, uniqueness: {scope: :nutrient_amount}
end
