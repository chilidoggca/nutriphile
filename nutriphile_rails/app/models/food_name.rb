class FoodName < ApplicationRecord
  validates :food_number, presence: true
  validates :food_code, presence: true
  validates :food_group_id, presence: true
  validates :food_source_id, presence: true
  validates :food_description, presence: true
  validates :food_date_of_entry, presence: true

  scope :get_food_info, -> (food_description) {
    where("food_description Ilike ?", "%#{food_description}%")
  }




end
