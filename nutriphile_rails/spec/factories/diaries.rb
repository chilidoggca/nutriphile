FactoryBot.define do
  factory :diary do
    diary_date {Date.current - rand(1..20)}
    meal_type {['Breakfast', 'Lunch', 'Dinner'].sample}
    food_name {Food.all.sample.food_name}
    amount {rand(1..100)}
    user {User.first}
  end
end
