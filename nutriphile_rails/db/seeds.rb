# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
FoodName.destroy_all
NutrientName.destroy_all
NutrientAmount.destroy_all

CSV.foreach("public/cnf-fcen-csv/FOODNAME.csv").with_index(1) do |row, line|
  unless line == 1
    FoodName.create(
      "#{FoodName.column_names[1]}": row[0],
      "#{FoodName.column_names[2]}": row[1],
      "#{FoodName.column_names[3]}": row[2],
      "#{FoodName.column_names[4]}": row[3],
      "#{FoodName.column_names[5]}": row[4],
      "#{FoodName.column_names[6]}": row[5],
      "#{FoodName.column_names[7]}": row[6],
      "#{FoodName.column_names[8]}": row[7],
      "#{FoodName.column_names[9]}": row[8],
      "#{FoodName.column_names[10]}": row[9]
    )
  end
end

food_names = FoodName.all
puts Cowsay.say("Create #{food_names.count} foodNames", :tux)

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

CSV.foreach("public/cnf-fcen-csv/NUTRIENTAMOUNT.csv").with_index(1) do |row, line|
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
