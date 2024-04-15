class ApplicationController < ActionController::Base
    helper_method :cart
    before_action :contact

    def contact
      @contact = Contact.first
    end

    def update_subcategories
        @subcategories = PlantSubcategory.where(plant_category_id: params[:category_id])

        respond_to do |format|
            format.turbo_stream
        end

        # render turbo_stream: turbo_stream.replace('subcategory_select', partial: '/layouts/subcategories', locals: { subcategories: subcategories })
    end

    def cart
        if not session[:cart].nil?
            cart_objects ||= session[:cart].map do |item|
              {
                plant: Plant.find(item['plant_id']), 
                amounts: item['amounts'].map do |amount|
                  { quantity: amount['quantity'], price: Price.find(amount['price_id']) }
                end 
              }
            end
        end
    end
end