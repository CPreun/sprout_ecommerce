class HomeController < ApplicationController
  def index
    @plant_categories = PlantCategory.all
  end
end
