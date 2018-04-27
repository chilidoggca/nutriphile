class FoodsController < ApplicationController
  before_action :set_food, only: [:show]
  # before_action :food_params, only: [:show, :edit, :update, :destroy]

  def index
    food_name_keyword = params[:food]
    if food_name_keyword
      search_food_name = food_name_keyword["search_food_name"]
      @food_names = Food.get_food_info(search_food_name)
    else
      @food_names = Food.all
    end
  end

  def show
    @nutrients = Nutrient.where(food_id: @food.id)
  end

  private
    def set_food
      @food = Food.find(params[:id])
    end

    def food_params
      params.require(:food).permit(:food_number, :food_code, :food_group_id, :food_source_id,
        :food_description, :food_description_f, :food_date_of_entry, :food_date_of_publication,
        :country_code, :scientific_name
      )
    end
end
