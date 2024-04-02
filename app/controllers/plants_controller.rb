class PlantsController < ApplicationController
  add_breadcrumb "Seeds", :plants_path

  # plant_params = params.require(:plant).permit(:plant_category_id, :plant_subcategory_id, :seed_type_id, 
  #                                               :name, :medicinal, :edible, :fruits, :thorns, :growth, 
  #                                               :care_level, :image_link, :info_link, 
  #                                               :sunlight_amount_ids => [], 
  #                                               :price_attributes => [:price, :weight, :quantity], 
  #                                               :plant_sunlight_amounts_attributes => [:sunlight_amount_id],
  #                                               :plant_subcategory_attributes => [:plant_subcategory],
  #                                               :plant_category_attributes => [:plant_category],
  #                                               :seed_type_attributes => [:seed_type])

  def index
    all_plants = Plant.all

    @plants_count = all_plants.count
    @plants = all_plants.includes(:prices, :plant_subcategory).order(:name).page(params[:page]).per(12)
  end

  def show
    @plant = Plant.includes(:prices, :seed_type, :plant_subcategory, :sunlight_amounts).find_by(name: params[:plant_name].gsub("_", " "))
    add_breadcrumb @plant.name, plants_path + "/" + @plant.name.gsub(" ", "_")
  end
end
