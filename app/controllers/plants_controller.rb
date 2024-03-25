class PlantsController < ApplicationController
  def index
    @plants = Plant.all
  end

  def show
    @plant = Plant.includes(:prices, :seed_type, :plant_subcategory, :sunlight_amounts).find_by(name: params[:plant_name].gsub("_", " "))
  end
end
