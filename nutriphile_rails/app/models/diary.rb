class Diary < ApplicationRecord
  belongs_to :user

  validates :meal_type, presence: true
end
