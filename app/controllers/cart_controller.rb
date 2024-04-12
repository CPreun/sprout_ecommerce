class CartController < ApplicationController
    before_action :initialize_cart

    def initialize_cart
        session[:cart] ||= []
    end
    
    def create
        # Reworded to be more readable
        if session[:cart].any? { |item| item['plant_id'] == params['plant_id'] }
            session[:cart].each do |item|
                if item['plant_id'] == params['plant_id']
                    if item['amounts'].any? { |amount| amount['price_id'] == params['price_id'] }
                        item['amounts'].each do |amount|
                            if amount['price_id'] == params['price_id']
                                amount['quantity'] += params['quantity'].to_i
                                break
                            end
                        end
                    else
                        item['amounts'] << { quantity: params['quantity'].to_i, price_id: params['price_id'] }
                        break
                    end
                end
            end
        else
            session[:cart] << { plant_id: params['plant_id'], amounts: [{ quantity: params['quantity'].to_i, price_id: params['price_id']}]}
        end
    end

    def update
        session[:cart].each do |item|
            if item['plant_id'] == params['plant_id']
                item['amounts'].each do |amount|
                    if amount['price_id'] == params['price_id']
                        amount['quantity'] = params['quantity']
                        break
                    end
                end
            end
        end
    end
    
    def destroy
        session[:cart].delete_if { |item| item['plant_id'] == params['id'] }
    end
end
