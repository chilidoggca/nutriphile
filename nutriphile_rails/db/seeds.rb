# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
Nutrient.destroy_all
Food.destroy_all
NutrientName.destroy_all
NutrientAmount.destroy_all
Diary.destroy_all
User.destroy_all


CSV.foreach("public/cnf-fcen-csv/FOODNAME.csv").with_index(1) do |row, line|
  unless line == 1
    Food.create(
      "#{Food.column_names[1]}": row[0],
      "#{Food.column_names[2]}": row[1],
      "#{Food.column_names[3]}": row[2],
      "#{Food.column_names[4]}": row[3],
      "#{Food.column_names[5]}": row[4],
      "#{Food.column_names[6]}": row[5],
      "#{Food.column_names[7]}": row[6],
      "#{Food.column_names[8]}": row[7],
      "#{Food.column_names[9]}": row[8],
      "#{Food.column_names[10]}": row[9]
    )
  end
end

foods = Food.all
puts Cowsay.say("Create #{foods.count} Foods", :tux)

CSV.foreach("public/cnf-fcen-csv/NUTRIENTNAME.csv").with_index(1) do |row, line|
  unless line == 1
    NutrientName.create(
      "#{NutrientName.column_names[1]}": row[0],
      "#{NutrientName.column_names[2]}": row[1],
      "#{NutrientName.column_names[3]}": row[2],
      "#{NutrientName.column_names[4]}": row[3],
      "#{NutrientName.column_names[5]}": row[4],
      "#{NutrientName.column_names[6]}": row[5],
      "#{NutrientName.column_names[7]}": row[6],
      "#{NutrientName.column_names[8]}": row[7],
    )
  end
end

nutrient_names = NutrientName.all
puts Cowsay.say("Create #{nutrient_names.count} NutrientNames", :ghostbusters)

CSV.foreach("public/cnf-fcen-csv/NUTRIENTAMOUNT2.csv").with_index(1) do |row, line|
  unless line == 1
    NutrientAmount.create(
      "#{NutrientAmount.column_names[1]}": row[0],
      "#{NutrientAmount.column_names[2]}": row[1],
      "#{NutrientAmount.column_names[3]}": row[2],
      "#{NutrientAmount.column_names[4]}": row[3],
      "#{NutrientAmount.column_names[5]}": row[4],
      "#{NutrientAmount.column_names[6]}": row[5],
      "#{NutrientAmount.column_names[7]}": row[6],
    )
  end
end

nutrient_amounts = NutrientAmount.all
puts Cowsay.say("Create #{nutrient_amounts.count} NUTRIENTAMOUNTS", :moose)

nutrient_amounts.each do |n_a|
  n_n = NutrientName.find_by(nutrient_number: n_a.nutrient_number)
  food = Food.find_by(food_number: n_a.food_number)
  Nutrient.create(
    nutrient_number: n_n.nutrient_number,
    nutrient_name_id: n_n.id,
    nutrient_amount_id: n_a.id,
    food_id: food.id
  )
end

nutrients = Nutrient.all
puts Cowsay.say("Create #{nutrients.count} nutrients", :moose)


PASSWORD = '123456'
test_user = User.create(
  email: 't@t.t',
  password: PASSWORD,
  password_confirmation: PASSWORD
)

rand(50..100).times.each do
  meal_type_arr = ['Breakfast', 'Lunch', 'Dinner']
  Diary.create(
    diary_date: Date.current - rand(1..20),
    meal_type: meal_type_arr.sample,
    food_name: foods.sample.food_name,
    amount: rand(1..30),
    user_id: test_user.id
  )
end


diaries = Diary.all
puts Cowsay.say("Create #{diaries.count} diaries", :moose)
