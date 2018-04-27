class Nutrient < ApplicationRecord
  belongs_to :nutrient_name
  belongs_to :nutrient_amount

  validates :nutrient_name, uniqueness: {scope: :nutrient_amount}
end
