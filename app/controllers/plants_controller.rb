class PlantsController < ApplicationController
  add_breadcrumb "Seeds", :plants_path

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
