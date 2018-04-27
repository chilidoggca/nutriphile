class Food < ApplicationRecord
  validates :food_number, presence: true
  validates :food_code, presence: true
  validates :food_group_id, presence: true
  validates :food_source_id, presence: true
  validates :food_name, presence: true
  validates :food_date_of_entry, presence: true

  scope :get_food_info, -> (food_name) {
    where("food_name Ilike ?", "%#{food_name}%")
  }


end
