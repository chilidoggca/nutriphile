class DiarySerializer < ActiveModel::Serializer
  attributes :id, :diary_date, :food_name, :amount, :user_id
  attribute :meal_type, key: :title
  attribute :start_end, key: :start
  attribute :start_end, key: :end
  # attributes :url

  def start_end
    object.created_at
  end
end
