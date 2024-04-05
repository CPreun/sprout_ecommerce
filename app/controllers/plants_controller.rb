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

  # def subcategories
  #   category = PlantCategory.find(params[:category_id])
  #   subcategories = category.plant_subcategories.map { |subcategory| {id: subcategory.id, name: subcategory.plant_subcategory} }
  #   render json: subcategories
  # end

  # def update_subcategories
  #   subcategories = PlantSubcategory.where(plant_category_id: params[:category_id])

  #   render turbo_stream: turbo_stream.replace('subcategory_select', partial: 'subcategories', locals: { subcategories: subcategories })
  # end

  def index
    all_plants = Plant.all

    if params[:category].present?
      all_plants = all_plants.joins(:plant_subcategory).where('plant_category_id = ?', params[:category])
      add_breadcrumb PlantCategory.find(params[:category]).plant_category, plants_path + "?plant_category=#{params[:category]}"
    end

    if params[:subcategory].present?
      all_plants = all_plants.where('plant_subcategory_id = ?', params[:subcategory])
      add_breadcrumb PlantSubcategory.find(params[:subcategory]).plant_subcategory, plants_path + "?plant_category=#{params[:category]}&subcategory=#{params[:subcategory]}"
    end

    # if not params[:subcategory].present? and params[:category].present?
    #   all_plants = all_plants.joins(:plant_subcategory).where('plant_category_id = ?', params[:category] )
    # end

    if params[:search].present?
      all_plants = all_plants.where('LOWER(name) LIKE ? OR LOWER(description) LIKE ?', "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    end

    @plants_count = all_plants.count
    @plants = all_plants.includes(:prices, :plant_subcategory).order(:name).page(params[:page]).per(12)
  end

  def show
    @plant = Plant.includes(:prices, :seed_type, :plant_subcategory, :sunlight_amounts).find_by(name: params[:plant_name].gsub("_", " "))
    add_breadcrumb @plant.plant_subcategory.plant_category.plant_category, plants_path + "?category=#{@plant.plant_subcategory.plant_category_id}"
    add_breadcrumb @plant.plant_subcategory.plant_subcategory, plants_path + "?category=#{@plant.plant_subcategory.plant_category_id}&subcategory=#{@plant.plant_subcategory_id}"
    add_breadcrumb @plant.name, plants_path + "/" + @plant.name.gsub(" ", "_")
  end
end
