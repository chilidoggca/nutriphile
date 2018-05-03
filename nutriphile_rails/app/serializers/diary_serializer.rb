class DiarySerializer < ActiveModel::Serializer
  attributes :id, :food_name, :amount, :user_id
  attribute :meal_type, key: :title
  attribute :diary_date, key: :start

  # attributes :url

end
