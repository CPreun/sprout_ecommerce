class CartController < ApplicationController
    before_action :initialize_cart

    def initialize_cart
        session[:cart] ||= []
    end
    
    def create
        # Check if the plant is already in the cart
        if session[:cart].any? { |item| item['plant_id'] == params['plant_id'] }
            # Find the plant in the cart
            session[:cart].each do |item|
            if item['plant_id'] == params['plant_id']
                # Check if the price is already in the plant's amounts
                if item['amounts'].any? { |amount| amount['price_id'] == params['price_id'] }
                    # Find the price in the plant's amounts
                    item['amounts'].each do |amount|
                        if amount['price_id'] == params['price_id']
                        # Update the quantity of the price
                        amount['quantity'] += params['quantity'].to_i
                        break
                        end
                    end
                else
                    # If price point not in cart, add new price to the plant
                    item['amounts'] << { quantity: params['quantity'].to_i, price_id: params['price_id'] }
                break
                end
            end
            end
        else
            # If plant id not found, add the new plant to the cart
            session[:cart] << { plant_id: params['plant_id'], amounts: [{ quantity: params['quantity'].to_i, price_id: params['price_id']}]}
        end
    end

    def update
        session[:cart].each do |item|
            if item['plant_id'] == params['id']
                item['amounts'].each do |amount|
                    if amount['price_id'] == params['price_id']
                        amount['quantity'] = params['quantity']
                        break
                    end
                end
            end
            item['amounts'].delete_if { |amount| amount['quantity'].to_i == 0 }
            session[:cart].delete_if { |item| item['amounts'].empty? }
        end
    end
    
    def destroy
        session[:cart].delete_if { |item| item['plant_id'] == params['id'] }
    end
end
