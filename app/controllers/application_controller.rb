class ApplicationController < ActionController::Base
    def update_subcategories
        @subcategories = PlantSubcategory.where(plant_category_id: params[:category_id])

        respond_to do |format|
            format.turbo_stream
        end

        # render turbo_stream: turbo_stream.replace('subcategory_select', partial: '/layouts/subcategories', locals: { subcategories: subcategories })
    end
end
