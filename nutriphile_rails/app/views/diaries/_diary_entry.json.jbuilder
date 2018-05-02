json.extract! diary, :id, :diary_date, :meal_type, :food_name, :user_id, :created_at, :updated_at
json.url diary_url(diary, format: :json)
