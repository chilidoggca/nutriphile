json.extract! diary_entry, :id, :diary_date, :meal_type, :food_name, :user_id, :created_at, :updated_at
json.url diary_entry_url(diary_entry, format: :json)
