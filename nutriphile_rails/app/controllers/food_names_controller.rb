class FoodNamesController < ApplicationController
  before_action :set_food, only: [:show]
  # before_action :food_params, only: [:show, :edit, :update, :destroy]

  def index
    food_name_keyword = params[:food_name]
    if food_name_keyword
      search_food_name = food_name_keyword["search_food_name"]
      @food_names = FoodName.get_food_info(search_food_name)
      puts @food_names.count
    else
      @food_names = FoodName.all
    end
  end

  def show
    @nutrients_amounts = NutrientAmount.where(food_number: @food.food_number)
    @nutrient_names = NutrientAmount.get_nutrient_name(@nutrients_amounts.ids)
  end

  private
    def set_food
      @food = FoodName.find(params[:id])
    end

    def food_params
      params.require(:food_name).permit(:food_number, :food_code, :food_group_id, :food_source_id,
        :food_description, :food_description_f, :food_date_of_entry, :food_date_of_publication,
        :country_code, :scientific_name
      )
    end
end
